" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/lsp_signature.nvim'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" my cmake toolchians
Plug 'xubury/toolchains'

Plug 'lilydjwg/fcitx.vim'

Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

" cmake
Plug 'ilyachur/cmake4vim'

" color scheme
Plug 'lifepillar/vim-gruvbox8'

" status line
Plug 'itchyny/lightline.vim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/vim-emoji'

Plug 'mhinz/vim-signify'

Plug 'preservim/nerdcommenter'
" Plug 'puremourning/vimspector'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'

Plug 'godlygeek/tabular'
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'

"lua plugin
Plug 'andrejlevkovitch/vim-lua-format'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" tmux navigator
Plug 'christoomey/vim-tmux-navigator'

" glsl filetype
Plug 'Eric-Song-Nop/vim-glslx'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'AckslD/nvim-neoclip.lua'
call plug#end()
"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

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

let mapleader = "\\"

set spelllang=en

set termguicolors
syntax enable
set background=dark
let g:gruvbox_italics=0
let g:gruvbox_italicize_strings=0
colorscheme gruvbox8

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
set number
set relativenumber
set nojoinspaces
set hidden

inoremap jj <esc>
nnoremap gi `^
nnoremap t `

:command Q q
:command Qa qa

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap <space><tab> :b# <cr>
noremap <space>w :bp<cr>:bd #<cr>
noremap <leader>n :noh<cr>

"Switch between different windows by their direction`
no <C-j> <C-w>j| "switching to below window
no <C-k> <C-w>k| "switching to above window
no <C-l> <C-w>l| "switching to right window
no <C-h> <C-w>h| "switching to left window

" Async
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

tnoremap <Esc> <C-\><C-n>


" clipboard
set clipboard+=unnamedplus

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


" indentline
autocmd VimEnter * if bufname('%') == '' | IndentLinesDisable | endif
