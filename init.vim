" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'ilyachur/cmake4vim'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

Plug 'jackguo380/vim-lsp-cxx-highlight'

" color scheme
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/vim-emoji'

" status line
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'

"Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
" Plug 'puremourning/vimspector'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" go plugin
Plug 'fatih/vim-go'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'

"lua plugin
Plug 'andrejlevkovitch/vim-lua-format'

" tagbar
Plug 'preservim/tagbar'
call plug#end()


source $VIMRUNTIME/mswin.vim

autocmd BufWritePost .vimrc so $MYVIMRC
autocmd BufWritePost *.vim so $MYVIMRC
autocmd BufWritePost vimrc.symlink so $MYVIMRC
set termencoding=utf-8
set encoding=utf-8
set showmatch
let mapleader = "\\"
let g:vimspector_enable_mappings = 'HUMAN'
let g:lightline = {
  \ 'colorscheme': 'dracula'
\}
set laststatus=2

set termguicolors
syntax enable
colorscheme dracula
set noshowmode
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set nu
set cursorline
set smarttab

set tabstop=4
set shiftwidth=4
set autoindent
set autoread
set expandtab
set cmdheight=2
set wildignorecase
set infercase
set smartcase
set ignorecase
set nu
set rnu
let g:indentLine_setConceal = 0

imap jj <esc>
nmap gi `^

:command Q q
:command Qa qa

set sel=inclusive
" Go to tab by number
noremap <C-1> 1gt
noremap <C-2> 2gt
noremap <C-3> 3gt
noremap <C-4> 4gt
noremap <C-5> 5gt
noremap <C-6> 6gt
noremap <C-7> 7gt
noremap <C-8> 8gt
noremap <C-9> 9gt
noremap <C-0> :tablast<cr>
noremap <C-w> :q<cr>
nnoremap <space>b :ls<CR>:b<Space>
noremap <space><tab> :b# <cr>
noremap <space>w :bp<cr>:bd #<cr>
noremap fs :Startify<cr>
" Selcet the whole word
vnoremap v iw
noremap <leader>n :noh<cr>

"Switch between different windows by their direction`
no <C-j> <C-w>j| "switching to below window
no <C-k> <C-w>k| "switching to above window
no <C-l> <C-w>l| "switching to right window
no <C-h> <C-w>h| "switching to left window

" Utlisnip
let g:UltiSnipsExpandTrigger = "<nop>"

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Async
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" vim-go settings
function! ReuseVimGoTerm(cmd) abort
    for w in nvim_list_wins()
        if "goterm" == nvim_buf_get_option(nvim_win_get_buf(w), 'filetype')
            call nvim_win_close(w, v:true)
            break
        endif
    endfor
    execute a:cmd
endfunction

let g:go_term_enabled = 1
let g:go_term_mode = "silent keepalt rightbelow 8 split"
let g:go_def_reuse_buffer = 1

autocmd FileType go nmap <leader>r :call ReuseVimGoTerm('GoRun')<Return>
if has('win32')|| has('win32unix')
    let g:python3_host_prog = 'C:/Users/Bury/miniconda3/python.exe'
    let $MSYSTEM = 'MINGW64'
    set shell=bash
    set shellcmdflag=--login\ -c
    set shellquote="
    set shellslash
    set shellquote=\"
    set shellxquote=
endif

autocmd FileType python nmap <leader>r :CocCommand python.execInTerminal<cr>

autocmd FileType cpp nmap <leader>g :CMake <cr>

autocmd BufEnter *.cpp set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ %<

autocmd FileType cpp nmap <leader>b :call CompileGcc()<CR>

func! CompileGcc()
    exec "w"
    if ! empty(glob('CMakeLists.txt'))
        exec "CMakeBuild"
    else
        exec "Make"
    endif
endfunc

let g:vim_markdown_math = 1

" vim-autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
au BufWrite * :Autoformat
let g:formatdef_my_custom_clang = '"clang-format -style=\"{BasedOnStyle: Google, IndentWidth: 4}\""'
let g:formatters_cpp = ['my_custom_clang']

" vim-lua-format
autocmd BufWrite *.lua call LuaFormat()

" vim-tex
let g:tex_flavor = 'latex'

if has('win32') || has('win32unix')
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
else
    let g:vimtex_view_general_viewer = 'zathura'
endif

let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'dvipdfex'         : '-pdfdvi',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}


" Toggle 'default' terminal
nnoremap <F4> :call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
nnoremap <F3> :call ChooseTerm("term-pane", 0)<CR>

function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "topleft split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "topleft split"
        endif
        :exe "terminal"
        :exe "f " a:termname
    endif
endfunction
tnoremap <Esc> <C-\><C-n>

" tag bar mapping
nmap <F8> :TagbarToggle<CR>
