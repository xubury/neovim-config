"use strict";
var __awaiter =
    (this && this.__awaiter) ||
    function (thisArg, _arguments, P, generator) {
        function adopt(value) {
            return value instanceof P
                ? value
                : new P(function (resolve) {
                      resolve(value);
                  });
        }
        return new (P || (P = Promise))(function (resolve, reject) {
            function fulfilled(value) {
                try {
                    step(generator.next(value));
                } catch (e) {
                    reject(e);
                }
            }
            function rejected(value) {
                try {
                    step(generator["throw"](value));
                } catch (e) {
                    reject(e);
                }
            }
            function step(result) {
                result.done
                    ? resolve(result.value)
                    : adopt(result.value).then(fulfilled, rejected);
            }
            step(
                (generator = generator.apply(thisArg, _arguments || [])).next()
            );
        });
    };
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmmyDebugSession = void 0;
const net = require("net");
const readline = require("readline");
const proto = require("./EmmyDebugProto");
const DebugSession_1 = require("./DebugSession");
const vscode_debugadapter_1 = require("vscode-debugadapter");
const EmmyDebugData_1 = require("./EmmyDebugData");
const fs_1 = require("fs");
const path_1 = require("path");
class EmmyDebugSession extends DebugSession_1.DebugSession {
    constructor() {
        super(...arguments);
        this.readHeader = true;
        this.currentCmd = proto.MessageCMD.Unknown;
        this.currentFrameId = 0;
        this.breakPointId = 0;
        this.evalIdCount = 0;
        this.listenMode = false;
        this.breakpoints = [];
        this.extensionPath = "";
        this.handles = new vscode_debugadapter_1.Handles();
    }
    initializeRequest(response, args) {
        response.body = {
            supportsEvaluateForHovers: true,
            supportTerminateDebuggee: true,
            supportsLogPoints: true,
            supportsHitConditionalBreakpoints: true,
            // supportsDelayedStackTraceLoading: true,
            // supportsCompletionsRequest: true
        };
        this.sendResponse(response);
    }
    launchRequest(response, args) {
        this.ext = args.ext;
        this.extensionPath = args.extensionPath;
        this.codePaths = args.codePaths;
        if (!args.ideConnectDebugger) {
            this.listenMode = true;
            const socket = net
                .createServer((client) => {
                    this.client = client;
                    this.sendResponse(response);
                    this.onConnect(this.client);
                    this.readClient(client);
                    this.sendEvent(
                        new vscode_debugadapter_1.Event("onNewConnection")
                    );
                })
                .listen(args.port, args.host)
                .on("listening", () => {
                    this.sendEvent(
                        new vscode_debugadapter_1.OutputEvent(
                            "hello world",
                            "stderr"
                        )
                    );
                    this.sendEvent(
                        new vscode_debugadapter_1.OutputEvent(
                            `Server(${args.host}:${args.port}) open successfully, wait for connection...\n`
                        )
                    );
                })
                .on("error", (err) => {
                    this.sendEvent(
                        new vscode_debugadapter_1.OutputEvent(
                            `${err}`,
                            "stderr"
                        )
                    );
                    response.success = false;
                    response.message = `${err}`;
                    this.sendResponse(response);
                });
            this.socket = socket;
            this.sendEvent(
                new vscode_debugadapter_1.Event("showWaitConnection")
            );
        } else {
            // send resp
            const client = net
                .connect(args.port, args.host)
                .on("connect", () => {
                    this.sendResponse(response);
                    this.onConnect(client);
                    this.readClient(client);
                })
                .on("error", (err) => {
                    response.success = false;
                    response.message = `${err}`;
                    this.sendResponse(response);
                });
        }
    }
    customRequest(command, response, args) {
        if (command === "stopWaitConnection") {
            this.sendEvent(new vscode_debugadapter_1.OutputEvent("---> stop"));
            this.sendEvent(new vscode_debugadapter_1.TerminatedEvent());
        } else {
            super.customRequest(command, response, args);
        }
    }
    onConnect(client) {
        this.sendEvent(new vscode_debugadapter_1.OutputEvent(`Connected.\n`));
        this.client = client;
        const extPath = this.extensionPath;
        const emmyHelperPath = (0, path_1.join)(
            extPath,
            "debugger/emmy/emmyHelper.lua"
        );
        // send init event
        const emmyHelper = (0, fs_1.readFileSync)(emmyHelperPath);
        const initReq = {
            cmd: proto.MessageCMD.InitReq,
            emmyHelper: emmyHelper.toString(),
            ext: this.ext,
        };
        this.sendMessage(initReq);
        // add breakpoints
        this.sendBreakpoints();
        // send ready
        this.sendMessage({ cmd: proto.MessageCMD.ReadyReq });
        this.sendEvent(new vscode_debugadapter_1.InitializedEvent());
    }
    readClient(client) {
        readline
            .createInterface({
                input: client,
                output: client,
            })
            .on("line", (line) => this.onReceiveLine(line));
        client
            .on("close", (hadErr) => this.onSocketClose())
            .on("error", (err) => this.onSocketClose());
    }
    onSocketClose() {
        if (this.client) {
            this.client.removeAllListeners();
        }
        this.sendEvent(
            new vscode_debugadapter_1.OutputEvent("Disconnected.\n")
        );
        if (this.listenMode) {
            this.client = undefined;
        } else {
            this.sendEvent(new vscode_debugadapter_1.TerminatedEvent());
        }
    }
    disconnectRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.Stop);
        setTimeout(() => {
            if (this.socket) {
                this.socket.close();
                this.socket = undefined;
            }
            if (this.client) {
                this.client.end();
                this.client = undefined;
            }
        }, 1000);
    }
    onReceiveLine(line) {
        if (this.readHeader) {
            this.currentCmd = parseInt(line);
        } else {
            const data = JSON.parse(line);
            this.handleDebugMessage(this.currentCmd, data);
        }
        this.readHeader = !this.readHeader;
    }
    handleDebugMessage(cmd, msg) {
        switch (cmd) {
            case proto.MessageCMD.BreakNotify:
                this.breakNotify = msg;
                this.sendEvent(
                    new vscode_debugadapter_1.StoppedEvent("breakpoint", 1)
                );
                break;
            case proto.MessageCMD.EvalRsp:
                this.emit("onEvalRsp", msg);
                break;
        }
    }
    sendMessage(msg) {
        if (this.client) {
            this.client.write(`${msg.cmd}\n`);
            this.client.write(`${JSON.stringify(msg)}\n`);
        }
    }
    threadsRequest(response) {
        response.body = {
            threads: [new vscode_debugadapter_1.Thread(1, "thread 1")],
        };
        this.sendResponse(response);
    }
    stackTraceRequest(response, args) {
        return __awaiter(this, void 0, void 0, function* () {
            if (this.breakNotify) {
                const stackFrames = [];
                const stacks = this.breakNotify.stacks;
                for (let i = 0; i < stacks.length; i++) {
                    const stack = stacks[i];
                    let fullFilename = "";
                    let filename = stack.file;
                    if (stack.line >= 0) {
                        if (
                            filename[0] == "." &&
                            (filename[1] == "/" || filename[1] == "\\")
                        ) {
                            filename = filename.substring(2);
                        }
                        for (let j = 0; j < this.codePaths.length; j++) {
                            fullFilename = this.findFile(
                                this.codePaths[j],
                                filename
                            );
                            if (fullFilename !== "") {
                                break;
                            }
                        }
                    } else if (i < stacks.length - 1) {
                        continue;
                    }
                    let source = new vscode_debugadapter_1.Source(
                        stack.file,
                        fullFilename
                    );
                    stackFrames.push(
                        new vscode_debugadapter_1.StackFrame(
                            stack.level,
                            stack.functionName,
                            source,
                            stack.line
                        )
                    );
                }
                response.body = {
                    stackFrames: stackFrames,
                    totalFrames: stackFrames.length,
                };
            }
            this.sendResponse(response);
        });
    }
    findFile(startPath, file) {
        if (path_1.isAbsolute(file)) {
            return file;
        }
        if (this._fileCache.has(file)) {
            return this._fileCache.get(file);
        }

        if (!fs_1.existsSync(startPath)) {
            this.sendEvent(
                new vscode_debugadapter_1.OutputEvent(
                    `fromDir:ERROR:startPath:${startPath},filter:${file}.\n`
                )
            );
            return "";
        }
        var files = fs_1.readdirSync(startPath);
        for (var i = 0; i < files.length; i++) {
            var filename = path_1.join(startPath, files[i]);
            var stat = fs_1.lstatSync(filename);
            if (stat.isDirectory()) {
                filename = this.findFile(filename, file); //recurse
                if (filename == "") {
                    continue;
                }
            } else if (!this.ext.includes(path_1.parse(files[i]).ext)) {
                // skip non-target file
                continue;
            }

            // match filename
            if (filename.indexOf(file) >= 0) {
                // cache max match filename
                if (
                    this._fileCache.has(file) &&
                    this._fileCache.get(file).length < filename.length
                ) {
                    this._fileCache.set(file, filename);
                } else {
                    this._fileCache.set(file, filename);
                }
            }
        }

        if (this._fileCache.has(file)) {
            return this._fileCache.get(file);
        }

        return "";
    }
    scopesRequest(response, args) {
        this.currentFrameId = args.frameId;
        if (this.breakNotify) {
            const stackData = this.breakNotify.stacks[args.frameId];
            const stack = new EmmyDebugData_1.EmmyStack(stackData);
            const env = new EmmyDebugData_1.EmmyStackENV(stackData);
            response.body = {
                scopes: [
                    {
                        name: "Variables",
                        variablesReference: this.handles.create(stack),
                        expensive: false,
                    },
                    {
                        name: "ENV",
                        variablesReference: this.handles.create(env),
                        expensive: false,
                    },
                ],
            };
        }
        this.sendResponse(response);
    }
    variablesRequest(response, args) {
        return __awaiter(this, void 0, void 0, function* () {
            if (this.breakNotify) {
                const node = this.handles.get(args.variablesReference);
                const children = yield node.computeChildren(this);
                response.body = {
                    variables: children.map((v) => v.toVariable(this)),
                };
            }
            this.sendResponse(response);
        });
    }
    evaluateRequest(response, args) {
        return __awaiter(this, void 0, void 0, function* () {
            const evalResp = yield this.eval(args.expression, 0);
            if (evalResp.success) {
                const emmyVar = new EmmyDebugData_1.EmmyVariable(
                    evalResp.value
                );
                const variable = emmyVar.toVariable(this);
                response.body = {
                    result: variable.value,
                    type: variable.type,
                    variablesReference: variable.variablesReference,
                };
            } else {
                response.body = {
                    result: evalResp.error,
                    type: "string",
                    variablesReference: 0,
                };
            }
            this.sendResponse(response);
        });
    }
    eval(expr, cacheId, depth = 1) {
        return __awaiter(this, void 0, void 0, function* () {
            const req = {
                cmd: proto.MessageCMD.EvalReq,
                seq: this.evalIdCount++,
                stackLevel: this.currentFrameId,
                expr: expr,
                depth: depth,
                cacheId: cacheId,
            };
            this.sendMessage(req);
            return new Promise((resolve, reject) => {
                const listener = (msg) => {
                    if (msg.seq === req.seq) {
                        this.removeListener("onEvalRsp", listener);
                        resolve(msg);
                    }
                };
                this.on("onEvalRsp", listener);
            });
        });
    }
    setBreakPointsRequest(response, args) {
        const source = args.source;
        const bpsProto = [];
        if (source && source.path) {
            const path = (0, path_1.normalize)(source.path);
            const bps = args.breakpoints || [];
            const bpsResp = [];
            for (let i = 0; i < bps.length; i++) {
                const bp = bps[i];
                bpsProto.push({
                    file: path,
                    line: bp.line,
                    condition: bp.condition,
                    hitCondition: bp.hitCondition,
                    logMessage: bp.logMessage,
                });
                const bpResp = new vscode_debugadapter_1.Breakpoint(
                    true,
                    bp.line
                );
                bpResp.id = this.breakPointId++;
                bpsResp.push(bpResp);
            }
            response.body = { breakpoints: bpsResp };
            this.breakpoints = this.breakpoints.filter((v) => v.file !== path);
            this.breakpoints = this.breakpoints.concat(bpsProto);
        }
        this.sendBreakpoints();
        this.sendResponse(response);
    }
    // protected completionsRequest(response: DebugProtocol.CompletionsResponse, args: DebugProtocol.CompletionsArguments, request?: DebugProtocol.Request): void {
    // }
    sendBreakpoints() {
        const req = {
            breakPoints: this.breakpoints,
            clear: true,
            cmd: proto.MessageCMD.AddBreakPointReq,
        };
        this.sendMessage(req);
    }
    sendDebugAction(response, action) {
        const req = { cmd: proto.MessageCMD.ActionReq, action: action };
        this.sendMessage(req);
        this.sendResponse(response);
    }
    pauseRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.Break);
    }
    continueRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.Continue);
    }
    nextRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.StepOver);
    }
    stepInRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.StepIn);
    }
    stepOutRequest(response, args) {
        this.sendDebugAction(response, proto.DebugAction.StepOut);
    }
}
exports.EmmyDebugSession = EmmyDebugSession;
//# sourceMappingURL=EmmyDebugSession.js.map
