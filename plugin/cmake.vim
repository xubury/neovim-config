let g:cmake_project_generator="Unix Makefiles"
let g:cmake_compile_commands=1
let g:cmake_build_type="Debug"
let g:make_arguments="-j$(nproc)"
let g:cmake_compile_commands_link='./'

let g:cmake_kits = {
            \  "mingw-gcc": {
            \  "toolchain_file": "~/.config/nvim/plugged/toolchains/mingw.cmake", 
            \    },
            \  "linux-gcc": {
            \  "toolchain_file": "~/.config/nvim/plugged/toolchains/linux.cmake", 
            \    }
            \}

