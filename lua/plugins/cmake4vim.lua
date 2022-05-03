local u = require("utils")
local g = vim.g
local fn = vim.fn

g.cmake_compile_commands = 1
g.cmake_build_type = "Debug"
g.make_arguments = "-j" .. u.num_of_processers
g.cmake_compile_commands_link = fn.getcwd()

g.cmake_vimspector_support = 1

if fn.has("win32") > 0 then
    local prefix = fn.stdpath("data") .. "/site/pack/packer/start/toolchains/"
    prefix = prefix:gsub("\\", "/")
    g.cmake_kits = {
        mingw_gcc = {
            generator = "MinGW Makefiles"
        },
        mingw_clang = {
            toolchain_file = prefix .. "windows-mingw-clang.cmake",
            generator = "MinGW Makefiles"
        }
    }
    g.cmake_selected_kit = "mingw_gcc"
end

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
    autocmd FileType c,cpp,cmake nnoremap <leader>g :CMake <cr>
    autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<
    autocmd FileType c autocmd BufEnter <buffer> set makeprg=gcc\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ %\ -o\ build/%<
    autocmd FileType c,cpp,cmake autocmd BufEnter <buffer> nnoremap <leader>b :call CompileGCC()<cr>
]],
    false
)
