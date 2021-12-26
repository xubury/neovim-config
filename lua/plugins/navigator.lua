require("navigator").setup(
    {
        lsp = {
            servers = {"cmake"},
            diagnostic_update_in_insert = true,
            disply_diagnostic_qf = false,
            format_on_save = false,
            code_action = {enable = false, sign = true, sign_priority = 40, virtual_text = true},
            diagnostic_scrollbar_sign = false,
            clangd = {
                cmd = {
                    "clangd",
                    "-j=4",
                    "--background-index",
                    "--limit-results=20",
                    "--header-insertion=never",
                    "--clang-tidy",
                    "--pretty"
                }
            }
        },
        default_mapping = false,
        keymaps = {
            {
                key = "<C-LeftMouse>",
                func = "require('navigator.definition').definition()"
            },
            {
                key = "gd",
                func = "require('navigator.definition').definition()"
            },
            {
                key = "gr",
                func = "require('navigator.reference').reference()"
            },
            {
                key = "K",
                func = "hover({ popup_opts = { border = single, max_width = 80 }})"
            },
            {
                key = "ca",
                func = "vim.lsp.buf.code_action()"
            },
            {
                key = "rn",
                func = "require('navigator.rename').rename()"
            },
            {
                key = "gn",
                func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})"
            },
            {
                key = "gp",
                func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})"
            },
            {
                key = "gP",
                func = "require('navigator.definition').definition_preview()"
            },
            {
                key = "<leader>t",
                func = "require('navigator.symbols').document_symbols()"
            },
            {
                key = "<A-F>",
                func = "formatting()",
                mode = "n"
            },
            {
                key = "<A-F>",
                func = "range_formatting()",
                mode = "v"
            }
        }
    }
)
