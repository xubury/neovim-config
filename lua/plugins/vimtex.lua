local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
g.tex_flavor = "latex"

if fn.executable("SumatraPDF") > 0 then
    g.vimtex_view_general_viewer = "SumatraPDF"
elseif fn.executable("zathura") > 0 then
    g.vimtex_view_general_viewer = "zathura"
end

g.vimtex_compiler_latexmk_engines = {
    ["_"] = "-xelatex",
    ["pdflatex"] = "-pdf",
    ["dvipdfex"] = "-pdfdvi",
    ["lualatex"] = "-lualatex",
    ["xelatex"] = "-xelatex",
    ["context (pdftex)"] = "-pdf -pdflatex=texexec",
    ["context (luatex)"] = "-pdf -pdflatex=context",
    ["context (xetex)"] = "pdf -pdflatex=''texexec --xtx''"
}

cmd [[

autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>b <Plug>(vimtex-compile)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>v <Plug>(vimtex-view)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>c <Plug>(vimtex-clean)

]]
