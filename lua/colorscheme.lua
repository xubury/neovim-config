local cmd = vim.cmd
local opt = vim.opt -- Colorscheme
opt.termguicolors = true
opt.background = "dark"
vim.g.gruvbox_italic_comments = false
vim.g.gruvbox_italic_keywords = false
cmd("syntax enable")
cmd("colorscheme gruvbox-flat")
