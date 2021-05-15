let g:cmake_project_generator="Unix Makefiles"
let g:cmake_compile_commands=1
let g:cmake_build_type="Debug"
" let g:cmake_build_dir="build"
let g:make_arguments="-j$(nproc)"
" let g:cmake_usr_args="-DCMAKE_MAKE_PROGAME=x86_64-w64-mingw32-make"
let g:cmake_compile_commands_link='.clangd'

let g:cmake_kits = {
            \  "mingw-gcc": {
            \  "toolchain_file": "~/toolchains/mingw.cmake", 
            \    } }

