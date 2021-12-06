local u = require("utils")
local g = vim.g
local cmd = vim.cmd

g.autoformat_verbosemode = 1
g.autoformat_autoindent = 0
g.autoformat_retab = 0
g.autoformat_remove_trailing_spaces = 1
g.formatdef_file_clang = '"clang-format -style=file"'
cmd [[
let g:formatdef_my_custom_clang = '"clang-format -style=\"{BasedOnStyle: Google, IndentWidth: 4, SortIncludes: false}\""'
]]
-- g.formatdef_my_custom_clang = '"clang-format -style="{BasedOnStyle: Google}""'
g.formatters_c = { "file_clang", "my_custom_clang"  }
g.formatters_cpp = {  "my_custom_clang" , "file_clang", }

-- let auto_format_type_list = ['c', 'cpp', 'python', 'tex']
-- autocmd BufWrite * if index(auto_format_type_list, &ft) >= 0 | Autoformat | endif
u.map('n', '<A-F>', ":Autoformat<CR>")
