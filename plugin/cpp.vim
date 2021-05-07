autocmd FileType cpp,cmake nmap <leader>g :CMake <cr>

autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<

autocmd FileType cpp,cmake autocmd BufEnter <buffer> nmap <leader>b :call CompileGcc()<CR>

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
