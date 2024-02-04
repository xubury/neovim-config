local colors = {
    blue = "#80a0ff",
    cyan = "#79dac8",
    black = "#080808",
    white = "#cdd6f4",
    red = "#ff5189",
    violet = "#d183e8",
    grey = "#303030",
    overlay = "#313244",
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
        a = { fg = colors.white, bg = colors.overlay },
    },
}

require("lualine").setup({
    options = {
        theme = bubbles_theme,
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = { "fileformat", "lsp_progress" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
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
