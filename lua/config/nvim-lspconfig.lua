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
