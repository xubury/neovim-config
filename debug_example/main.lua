-- copy EmmyDebugSession.js to ${emmylua_path}/out/debugger
package.cpath = package.cpath
	.. ";C:/Users/bury/.vscode/extensions/tangzx.emmylua-0.5.11/debugger/emmy/windows/x64/emmy_core.dll"
local dbg = require("emmy_core")
dbg.tcpListen("localhost", 9966)
dbg.waitIDE()

require("debug_example")
print("yes?")

local incre = function (var)
    return var + 2;
end

local hello = 1
hello = incre(hello)
print(hello)
