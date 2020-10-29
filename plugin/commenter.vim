vmap <space>/ <plug>NERDCommenterSexy
nmap <space>/ <plug>NERDCommenterSexy

if has('win32')
nmap <C-/> <plug>NERDCommenterToggle
vmap <C-/> <plug>NERDCommenterToggle
else
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle
endif

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**', 'leftAlt': '*','right': '*/' },'cpp': { 'left': '/**', 'leftAlt': '*','right': '*/' } }

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
