local cmd = vim.cmd
local g = vim.g

cmd [[
autocmd VimEnter * if bufname('%') == '' | IndentLinesDisable | endif
]]

g.indentLine_fileTypeExclude = {"NvimTree"}
