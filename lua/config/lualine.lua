local palette = require("catppuccin.palettes").get_palette()

require("lualine").setup({
    options = {
        theme = "catppuccin",
        component_separators = "",
        section_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "fileformat", "filetype", "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
    },
    tabline = {},
    extensions = { "nvim-dap-ui", "toggleterm", "neo-tree", "quickfix" },
})

vim.opt.showmode = false
