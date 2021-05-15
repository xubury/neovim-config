autocmd FileType cpp,cmake nmap <leader>g :CMake <cr>

if IsWSL()
    autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=x86_64-w64-mingw32-g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<
else
    autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<
endif


autocmd FileType cpp,cmake autocmd BufEnter <buffer> nmap <leader>b :call CompileGcc()<CR>

func! CompileGcc()
    exec "w"
    if ! empty(glob('CMakeLists.txt'))
        exec "CMakeBuild"
    elseif ! empty(glob('Makefile'))
        exec "Dispatch make"
    else
        exec "!mkdir build"
        exec "Make"
    endif
endfunc
