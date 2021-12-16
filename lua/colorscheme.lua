local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
opt.termguicolors = true
opt.background = "dark"
g.gruvbox_italic_comments = false
g.gruvbox_italic_keywords = false
g.gruvbox_flat_style = "dark"
cmd("syntax enable")
cmd("colorscheme gruvbox-flat")
