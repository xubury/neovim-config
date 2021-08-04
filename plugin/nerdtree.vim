"" nerdtree settings
let g:NERDTreeShowBookmarks = 1

noremap <silent> <leader>n :call OpenNERDTree()<CR>

function! OpenNERDTree()
    exe 'NERDTreeToggle'
    if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
        exe "normal! \<c-w>\<c-w>"
    endif
endfunction


let g:NERDTreeMinimalMenu = 1

let NERDTreeMinimalUI = 1

let NERDTreeDirArrows = 1

let NERDTreeAutoDeleteBuffer = 1

let g:DevIconsEnableFoldersOpenClose = 1

" nerdtree git
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusConcealBrackets = 0


" For closing vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeIsOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1) && g:NERDTree.IsOpen()
endfunction

function! NERDTreeSync()
    if &modifiable && !&diff && NERDTreeIsOpen() && strlen(expand('%')) > 0 && bufname('%') !~# "^NERD_tree_"
        NERDTreeFind
        setlocal cursorline
        wincmd p
    endif
endfunction

" Auto sync
autocmd bufenter * call NERDTreeSync()

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'M',
    \ 'Staged'    :'A',
    \ 'Untracked' :'U',
    \ 'Renamed'   :'R',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'D',
    \ 'Dirty'     :'!',
    \ 'Ignored'   :'I',
    \ 'Clean'     :'C',
    \ 'Unknown'   :'?',
    \ }
