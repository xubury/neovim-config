local nvim_lsp = require("lspconfig")

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
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
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



-- LSP notify integration
-- Make sure to also have the snippet with the common helper functions in your config!
local notify = require("plugins/notify")
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
        return
    end

    local notif_data = notify.get_notif_data(client_id, result.token)

    if val.kind == "begin" then
        local message = notify.format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, "info", {
            title = notify.format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
            icon = notify.spinner_frames[1],
            timeout = false,
            hide_from_history = false,
        })

        notif_data.spinner = 1
        notify.update_spinner(client_id, result.token)
    elseif val.kind == "report" and notif_data then
        notif_data.notification = vim.notify(notify.format_message(val.message, val.percentage), "info", {
            replace = notif_data.notification,
            hide_from_history = false,
        })
    elseif val.kind == "end" and notif_data then
        notif_data.notification = vim.notify(val.message and notify.format_message(val.message) or "Complete", "info", {
            icon = "",
            replace = notif_data.notification,
            timeout = 3000,
        })

      notif_data.spinner = nil
    end
end

-- table from lsp severity to vim severity.
local severity = { "error", "warn", "info", "info" }

vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
    vim.notify(method.message, severity[params.type])
end
