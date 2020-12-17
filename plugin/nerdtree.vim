"" nerdtree settings
let g:NERDTreeShowBookmarks=1

"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>v :NERDTreeFind<CR>


let g:NERDTreeShowHidden=1

let NERDTreeMinimalUI = 1

let NERDTreeDirArrows = 1

let NERDTreeAutoDeleteBuffer = 1