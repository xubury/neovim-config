" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')
" my cmake toolchians
Plug 'xubury/toolchains'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'lilydjwg/fcitx.vim'
Plug 'Yggdroot/indentLine'
" Plug 'mhinz/vim-startify'
Plug 'ilyachur/cmake4vim'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

" Plug 'jackguo380/vim-lsp-cxx-highlight'

" color scheme
" Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-emoji'

" status line
Plug 'itchyny/lightline.vim'


Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
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
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'

"lua plugin
Plug 'andrejlevkovitch/vim-lua-format'

" tagbar
Plug 'preservim/tagbar'

" global search
Plug 'dyng/ctrlsf.vim'

" telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" tmux navigator
Plug 'christoomey/vim-tmux-navigator'

" glsl filetype
Plug 'Eric-Song-Nop/vim-glslx'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+


" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<Esc>:update<CR>gi


set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set showmatch
set nohlsearch

let mapleader = "\\"
let g:vimspector_enable_mappings = 'HUMAN'

set spelllang=en

set termguicolors
syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'

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
nnoremap gi `^
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

" WSL yank support
let s:clip = 'clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' && v:event.regname is '+' | call system('cat |' . s:clip, @+) | endif
    augroup END
endif

" file format
if has('win32') || has('win32unix')
    set ff=dos
else
    set ff=unix
endif

function! IsWSL() abort
  let proc_version = '/proc/version'
  return filereadable(proc_version)
        \  ? !empty(filter(
        \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
        \  : v:false
endfunction

let g:silent_unsupported = 1
