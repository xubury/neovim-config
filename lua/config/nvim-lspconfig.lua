vim.lsp.set_log_level("OFF")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- clangd 需要使用 utf-16 偏移编码
local clangd_cap = vim.deepcopy(capabilities)
clangd_cap.offsetEncoding = { "utf-16" }

-- 所有 LSP 共享的默认配置
vim.lsp.config("*", {
    capabilities = capabilities,
})

-- 统一处理 LSP attach 时的逻辑（替代原来每个 server 各自的 on_attach）
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        client.server_capabilities.semanticTokensProvider = nil
        require("keymap").on_attach(client, args.buf)
    end,
})

-- Lua
vim.lsp.config("lua_ls", {
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
            semantic = {
                enable = false,
            },
        },
    },
})

-- C/C++
vim.lsp.config("clangd", {
    capabilities = clangd_cap,
    cmd = { "clangd", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- 启用各 LSP 服务器
vim.lsp.enable({
    "vimls",
    "lua_ls",
    "clangd",
    "neocmake",
    "pyright",
    "csharp_ls",
    "ts_ls",
})

-- 诊断符号
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

-- 方案 D：包装 LSP show_document，跳转前规范化路径，避免产生重复 buffer
local _orig_show_document = vim.lsp.util.show_document
vim.lsp.util.show_document = function(location, position_encoding, opts)
    if type(location) == "table" then
        local uri = location.uri or location.targetUri
        if type(uri) == "string" and uri:match("^file://") then
            local fname = vim.uri_to_fname(uri)
            local norm = vim.fs.normalize(vim.fn.fnamemodify(fname, ":p"))
            local existing = vim.fn.bufnr(norm)
            if existing > 0 and vim.api.nvim_buf_is_loaded(existing) then
                local new_uri = vim.uri_from_fname(norm)
                location = vim.deepcopy(location)
                if location.uri then
                    location.uri = new_uri
                end
                if location.targetUri then
                    location.targetUri = new_uri
                end
            end
        end
    end
    return _orig_show_document(location, position_encoding, opts)
end

-- 方案 D2：hook vim.uri_to_bufnr，源头拦截 LSP rename / apply_text_document_edit / diagnostic 等
-- 这些路径不走 show_document，会直接 bufadd(uri_to_fname(uri))。
-- 我们让它优先返回已存在的同路径 buffer，避免产生重复。
local _orig_uri_to_bufnr = vim.uri_to_bufnr
vim.uri_to_bufnr = function(uri)
    if type(uri) == "string" and uri:match("^file://") then
        local fname = vim.uri_to_fname(uri)
        local norm = vim.fs.normalize(vim.fn.fnamemodify(fname, ":p"))
        local existing = vim.fn.bufnr(norm)
        if existing > 0 then
            return existing
        end
    end
    return _orig_uri_to_bufnr(uri)
end
