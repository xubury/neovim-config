local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local cmd = vim.cmd

g.mapleader = " "

opt.mouse = "a" -- enable mouse support
opt.swapfile = false
opt.termguicolors = true

opt.guifont = "MesloLGM Nerd Font:h14"

-- UI
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.wildignorecase = true
opt.infercase = true
opt.smartcase = true
opt.ignorecase = true
opt.signcolumn = "yes:1"
opt.cursorline = false
opt.winblend = 15
opt.pumblend = 15
opt.laststatus = 2 -- (3: Global status line)
opt.autoread = true

-- Tabs, indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true

-- Wrap
vim.wo.wrap = true

-- Memory
opt.hidden = true -- background buffer
opt.history = 100
opt.lazyredraw = false
opt.synmaxcol = 240 -- max column for syntax highlight
opt.updatetime = 100

-- Autocomplete
opt.completeopt = "menu,menuone,noinsert"

-- Syntax
opt.conceallevel = 0

-- Encoding
opt.encoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- Exclusive inclusive behaviors
opt.selection = "old"

-- Clipboard
opt.clipboard:append("unnamedplus")

cmd("syntax enable")

-- Auto update file change on disk
vim.api.nvim_create_autocmd("FocusGained", { pattern = "*", command = "checktime" })

-- Forbid neovim formatting comment when changing to a newline
vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = "*", command = "set formatoptions-=c formatoptions-=r formatoptions-=o" }
)

-- Prevent typo
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- don't jump while search
opt.incsearch = false

vim.opt.shortmess = "filnxtToOFIW"
