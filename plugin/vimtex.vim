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

autocmd FileType tex nmap <leader>b <Plug>(vimtex-compile)
autocmd FileType tex nmap <leader>v <Plug>(vimtex-view)
