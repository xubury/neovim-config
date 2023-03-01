local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local fn = vim.fn
local cmd = vim.cmd

g.mapleader = " "

opt.mouse = "a" -- enable mouse support
opt.swapfile = false
opt.termguicolors = true

opt.guifont = "Sarasa Mono SC"

-- UI
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.wildignorecase = true
opt.infercase = true
opt.smartcase = true
opt.ignorecase = true
opt.signcolumn = "yes:1"
opt.cursorline = true
opt.winblend = 15
opt.pumblend = 15

-- Tabs, indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.autoread = true
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
opt.selection = "exclusive"

-- Disable auto correct file format for now because of git crlf setting
-- File format
-- if fn.has("win32") > 0 then
--     opt.fileformats = "dos"
-- elseif fn.has("unix") > 0 then
--     opt.fileformats = "unix"
-- end

-- Clipboard
opt.clipboard:append("unnamedplus")

cmd("syntax enable")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.gltf", command = "setfiletype json" })
vim.api.nvim_create_autocmd("FocusGained", { pattern = "*", command = "checktime" })
