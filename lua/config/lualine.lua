local palette = require("catppuccin.palettes").get_palette()

local colors = {
    blue = palette.blue,
    cyan = palette.sky,
    black = "#080808",
    white = palette.text,
    red = palette.red,
    violet = palette.mauve,
    base = palette.base,
    overlay = palette.surface0,
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = {},
        c = {},
    },
    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    terminal = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.white, bg = colors.base },
    },
}

require("lualine").setup({
    options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = { "lsp_progress" },
        lualine_x = {},
        lualine_y = { "fileformat", "filetype", "progress" },
        lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
    },
    tabline = {},
    extensions = {},
})

vim.opt.showmode = false
vim.opt.cmdheight = 0
