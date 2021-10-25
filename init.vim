" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/lsp_signature.nvim'

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
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-emoji'

" status line
Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdcommenter'
" Plug 'puremourning/vimspector'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular'
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'

"lua plugin
Plug 'andrejlevkovitch/vim-lua-format'

" tagbar
Plug 'preservim/tagbar'

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

Plug 'AckslD/nvim-neoclip.lua'
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

inoremap jj <esc>
nnoremap gi `^
nnoremap t `

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
noremap <space><tab> :b# <cr>
noremap <space>w :bp<cr>:bd #<cr>
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

" Async
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

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

" indentline
autocmd VimEnter * if bufname('%') == '' | IndentLinesDisable | endif
