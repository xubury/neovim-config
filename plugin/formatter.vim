" vim-autoformat
let g:autoformat_verbosemode = 0
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 1
let g:formatdef_my_custom_clang = '"clang-format -style=\"{BasedOnStyle: Google, IndentWidth: 4, SortIncludes: false}\""'
let g:formatters_cpp = ['my_custom_clang']

" let auto_format_type_list = ['c', 'cpp', 'python', 'tex']
" autocmd BufWrite * if index(auto_format_type_list, &ft) >= 0 | Autoformat | endif
noremap <A-F> :Autoformat<CR>

" vim-lua-format
autocmd BufWrite *.lua call LuaFormat()
