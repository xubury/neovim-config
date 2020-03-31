" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhinz/vim-startify'
Plug 'ilyachur/cmake4vim'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'

Plug 'junegunn/vim-emoji'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'

Plug 'preservim/nerdcommenter'
Plug 'puremourning/vimspector'
call plug#end()

let g:vimspector_enable_mappings = 'HUMAN'

let g:airline_theme= 'deus'
let g:airline_powerline_fonts = 1
set relativenumber
set smarttab

colorscheme onedark
syntax on
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set cmdheight=2
set wildignorecase
set infercase
set smartcase
set ignorecase

source $VIMRUNTIME/mswin.vim

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
noremap <space>w :bd<cr>:bn<cr>
noremap fs :Startify<cr>
" Selcet the whole word
nnoremap vv viw

"Switch between different windows by their direction`
no <C-j> <C-w>j| "switching to below window 
no <C-k> <C-w>k| "switching to above window
no <C-l> <C-w>l| "switching to right window 
no <C-h> <C-w>h| "switching to left window


" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Async
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
