" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'lilydjwg/fcitx.vim'
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


Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'

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

" global search
Plug 'dyng/ctrlsf.vim'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

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

set spelllang=en

set termguicolors
syntax enable
colorscheme dracula

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

inoremap jj <esc>
nmap gi `^
nnoremap t `

" :command Q q
" :command Qa qa

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

" Copy without overriding the register
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

" Utlisnip
let g:UltiSnipsExpandTrigger = "<nop>"

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

autocmd FileType cpp,cmake nmap <leader>g :CMake <cr>

autocmd BufEnter *.cpp set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<

autocmd FileType cpp,cmake nmap <leader>b :call CompileGcc()<CR>

func! CompileGcc()
    exec "w"
    if ! empty(glob('CMakeLists.txt'))
        exec "CMakeBuild"
    elseif ! empty(glob('Makefile'))
        exec "AsyncRun make"
    else
        exec "Make"
    endif
endfunc

let g:vim_markdown_math = 1

" vim-autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
au BufWrite * :Autoformat
let g:formatdef_my_custom_clang = '"clang-format -style=\"{BasedOnStyle: Google, IndentWidth: 4}\""'
let g:formatters_cpp = ['my_custom_clang']

" vim-lua-format
autocmd BufWrite *.lua call LuaFormat()

" vim-tex
let g:tex_flavor = 'latex'

if has('win32') || has('win32unix')
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
    set ff=dos
else
    let g:vimtex_view_general_viewer = 'zathura'
    set ff=unix
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


" Toggle  terminal
nnoremap <silent> <F3> :call ChooseTerm("term-slider", "botright 16split")<CR>
nnoremap <silent> <F4> :call ChooseTerm("term-slider", "botright vsplit")<CR>

function! ChooseTerm(termname, slider_type)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        :exe pane . "wincmd c"
    elseif buf > 0
        " buffer is not in pane
        :exe a:slider_type
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        :exe a:slider_type
        :exe "term bash"
        :exe "f ". a:termname
    endif
endfunction

tnoremap <Esc> <C-\><C-n>

" tag bar mapping
nnoremap <silent> <leader>t :TagbarToggle<CR>

" ctrlsf
if !exists('g:vscode')
    nnoremap <C-f> :CtrlSF<Space>
endif
