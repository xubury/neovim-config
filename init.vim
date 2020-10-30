" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'honza/vim-snippets'

Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'ilyachur/cmake4vim'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'

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
" Plug 'puremourning/vimspector'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'Chiel92/vim-autoformat'
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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme= 'deus'
let g:airline_powerline_fonts = 1
set nu
set cursorline
set smarttab

syntax enable
set background=dark
colorscheme onedark
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
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
noremap <space><tab> :bp <cr>
noremap <space>w :bp<cr>:bd #<cr>
noremap fs :Startify<cr>
" Selcet the whole word
vnoremap v iw
noremap <C-n> :noh<cr>

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

autocmd FileType cpp nmap <leader>b :CMakeBuild<cr>
autocmd FileType cpp nmap <leader>g :CMake <cr>

autocmd BufEnter *.cpp set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ %\ -o\ %<
map <F5> :call CompileGcc()<CR>
func! CompileGcc()
    exec "w"
    exec "Make"
endfunc

let g:vim_markdown_math = 1

au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatdef_my_custom_clang = '"clang-format -style=google"' 
let g:formatters_cpp = ['my_custom_clang']

