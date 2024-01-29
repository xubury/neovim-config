local g = vim.g
g.indent_blankline_filetype_exclude = { "neo-tree", "alpha" }

require("indent_blankline").setup({
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
})
