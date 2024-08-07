local nvim_lsp = require("lspconfig")
local root_pattern = require("lspconfig.util").root_pattern

vim.lsp.set_log_level("OFF")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function lsp_setup(lsp, extra)
    local defaults = {
        on_attach = function(client, bufnr)
            require("keymap").on_attach(client, bufnr)
        end,
        capabilities = capabilities,
    }
    nvim_lsp[lsp].setup(vim.tbl_extend("force", defaults, extra or {}))
end

lsp_setup("vimls") -- Vim

-- Lua
lsp_setup("lua_ls", {
    root_dir = root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", "selene.toml", "selene.yml", ".git"),
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
            },
            semantic = {
                enable = false,
            },
        },
    },
})

-- cpp
local clangd_cap = vim.deepcopy(capabilities)
clangd_cap.offsetEncoding = { "utf-16" }
lsp_setup("clangd", {
    capabilities = clangd_cap,
    cmd = { "clangd", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- cmake
lsp_setup("neocmake")

-- python
lsp_setup("pyright")

-- typescript
lsp_setup("tsserver")

-- vue
lsp_setup("volar")

lsp_setup("csharp_ls")

-- Sign icons
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
