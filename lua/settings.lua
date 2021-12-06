local cmd = vim.cmd     				-- execute Vim commands
local g = vim.g         				-- global variables
local opt = vim.opt         		    -- global/buffer/windows-scoped options

g.mapleader = '\\'  -- change leader key
opt.mouse = 'a'  -- enable mouse support
opt.swapfile = false

-- UI
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.wildignorecase = true
opt.infercase = true
opt.smartcase = true
opt.ignorecase = true

-- Tabs, indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.autoread = true
opt.expandtab = true

-- Memory
opt.hidden = true -- background buffer
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240 -- max column for syntax highlight

-- Colorscheme
opt.termguicolors = true
cmd('syntax enable')
opt.background = 'dark'
g.gruvbox_italics=0
g.gruvbox_italicize_strings=0
cmd('colorscheme gruvbox8')

-- Autocomplete
opt.completeopt = 'menuone,noselect'

-- Encoding
opt.encoding = 'utf-8'
opt.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1'

-- Clipboard
opt.clipboard:append('unnamedplus')


-- Update time (for signify)
opt.updatetime = 100
