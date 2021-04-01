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
