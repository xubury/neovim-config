local u = require("utils")
local g = vim.g

g.cmake_compile_commands = 1
g.cmake_build_type = "Debug"
g.make_arguments = "-j$(nproc)"
g.cmake_compile_commands_link = "./"

g.cmake_kits = {
    mingw_gcc = {
        toolchain_file = "~/.local/share/nvim/site/pack/packer/start/toolchains/mingw.cmake",
        generator = "Unix Makefiles"
    }
}

u.execute(
    [[
    func! CompileGCC()
        if ! empty(glob('CMakeLists.txt'))
            exec "CMakeBuild"
        elseif ! empty(glob('Makefile'))
            exec "Dispatch make"
        else
            exec "!mkdir build"
            exec "Make"
        endif
    endfunc
    autocmd FileType cpp,cmake nnoremap <leader>g :CMake <cr>
    autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<
    autocmd FileType cpp,cmake autocmd BufEnter <buffer> nnoremap <leader>b :call CompileGCC()<cr>
]],
    false
)
