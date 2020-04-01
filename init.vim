" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
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

Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'puremourning/vimspector'
call plug#end()

set termencoding=utf-8
set encoding=utf-8

let g:python3_host_prog='C:/msys64/mingw64/bin/python3.exe'

let g:vimspector_enable_mappings = 'HUMAN'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
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
noremap <space>1 :b 1<cr>
noremap <space>2 :b 2<cr>
noremap <space>3 :b 3<cr>
noremap <space>4 :b 4<cr>
noremap <space>5 :b 5<cr>
noremap <space>6 :b 6<cr>
noremap <space>7 :b 7<cr>
noremap <space>8 :b 8<cr>
noremap <space>9 :b 9<cr>
noremap <space>w :bp<cr>:bd #<cr>
noremap fs :Startify<cr>
" Selcet the whole word
vnoremap v iw

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

function! PreciseTrimWhiteSpace()
  " We need to save the view because the substitute command might
  " or might not move the cursor, depending on whether it finds
  " any whitespace.
  let saved_view = winsaveview()

  " Remove white space. Ignore "not found" errors. Don't change jumplist.
  keepjumps '[,']s/\s\+$//e

  " Move cursor back if necessary.
  call winrestview(saved_view)
endfunction

augroup PreciseTrimWhiteSpace
  autocmd!
  autocmd InsertLeave * call PreciseTrimWhiteSpace()
augroup end
