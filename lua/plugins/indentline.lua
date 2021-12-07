local cmd = vim.cmd

cmd [[
autocmd VimEnter * if bufname('%') == '' | IndentLinesDisable | endif
]]
