require("nvim-lsp-installer").setup({
    ensure_installed = {"sumneko_lua", "pyright", "vimls"},
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local nvim_lsp = require("lspconfig")
local u = require("utils")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true, buffer = bufnr}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    u.map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    u.map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    u.map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    u.map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- u.map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    u.map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    u.map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    u.map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    u.map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    u.map("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    u.map("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    u.map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    u.map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    u.map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    u.map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    u.map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    u.map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Vim
nvim_lsp.vimls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false
            }
        }
    }
}

-- CPP
nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--header-insertion=never",
    },
    filetypes = {"c", "cpp", "objc", "objcpp"}
}

-- cmake
nvim_lsp.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- latex
nvim_lsp.texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- python
nvim_lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
