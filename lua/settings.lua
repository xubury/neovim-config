local u = require("utils")
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local fn = vim.fn

g.mapleader = "\\" -- change leader key

opt.mouse = "a" -- enable mouse support
opt.swapfile = false

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
opt.updatetime = 100

-- Autocomplete
opt.completeopt = "menuone,noselect"

-- Encoding
opt.encoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- WSL clipboard
if fn.has("wsl") > 0 then
    u.execute(
        [[
    let clip = 'clip.exe'
    if executable(clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' && v:event.regname is '+' | call system('cat |' . clip, @+) | endif
        augroup END
    endif
]],
        false
    )
end

-- Shell
if fn.has("win32") > 0 then
    -- To use powershell, see :help shell-powershell
    opt.shell = "cmd"
end
