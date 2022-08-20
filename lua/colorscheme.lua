local cmd = vim.cmd
require("catppuccin").setup()
vim.g.catppuccin_flavour = "mocha"
cmd("colorscheme catppuccin")
cmd("syntax enable")
