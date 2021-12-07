local cmd = vim.cmd

cmd [[
hi default GHTextViewDark guifg=#ebdbb2 guibg=#282828
hi default GHListDark guifg=#ebdbb2 guibg=#282828
hi default GHListHl guifg=#282828 guibg=#83a598
]]

require("nvim-autopairs").setup(
    {
        disable_filetype = {"TelescopePrompt", "guihua"}
    }
)

require("lsp_signature").setup()

require("navigator").setup(
    {
        lsp = {
            servers = {"cmake"},
            diagnostic_update_in_insert = true,
            disply_diagnostic_qf = false,
            format_on_save = false,
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
                func = "require('navigator.codeAction').code_action()"
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
