require("notify").setup({
    stages = "static",
    timeout = 1500,
    top_down = true,
})
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    notify = {
        enabled = true,
        view = "notify",
        opts = {},
    },
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
    },
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "mini", -- view for errors
        view_warn = "mini", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "mini", -- view for search count messages. Set to `false` to disable
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
        {
            filter = {
                event = "notify",
                min_height = 5,
                min_width = 12,
            },
            view = "split",
        },
        {
            filter = {
                event = "msg_show",
                find = "%d+L, %d+B",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                    { find = "fewer" },
                    { find = "more" },
                },
            },
            view = "mini",
        },
    },
})
