local g = vim.g
local cmd = vim.cmd

g.cmake_compile_commands = 1
g.cmake_build_type = 'Debug'
g.make_arguments = "-j$(nproc)"
g.cmake_compile_commands_link = './'


cmd [[
let g:cmake_kits = {
    \  "mingw-gcc": {
    \  "toolchain_file": "~/.local/share/nvim/site/pack/packer/start/toolchains/mingw.cmake", 
    \  "generator" : "Unix Makefiles"
    \    }
    \}
]]

cmd [[ 
    autocmd FileType cpp,cmake nmap <leader>g :CMake <cr> 
    autocmd FileType cpp autocmd BufEnter <buffer> set makeprg=g++\ -g\ -Wall\ -Wextra\ -Wundef\ -pedantic\ -std=c++17\ %\ -o\ build/%<
    autocmd FileType cpp,cmake autocmd BufEnter <buffer> nmap <leader>b :lua require('cpp').CompileGCC()<CR>
]]
