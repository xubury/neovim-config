local u = require("utils")
local g = vim.g

g.autoformat_verbosemode = 1
g.autoformat_autoindent = 0
g.autoformat_retab = 0
g.autoformat_remove_trailing_spaces = 1
g.formatdef_file_clang = '"clang-format -style=file"'
local cpp_style = "{BasedOnStyle: Google, IndentWidth: 4, SortIncludes: false}"
g.formatdef_my_custom_clang = string.format('"clang-format -style=\\"%s\\""', cpp_style)
g.formatters_c = {"file_clang", "my_custom_clang"}
g.formatters_cpp = {"file_clang", "my_custom_clang"}

-- let auto_format_type_list = ['c', 'cpp', 'python', 'tex']
-- autocmd BufWrite * if index(auto_format_type_list, &ft) >= 0 | Autoformat | endif
u.map("n", "<A-F>", ":Autoformat<CR>")
