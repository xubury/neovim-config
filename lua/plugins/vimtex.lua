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

g.vimtex_syntax_concal = {
    ["accents"] = 1,
    ["cites"] = 0,
    ["fancy"] = 1,
    ["greek"] = 1,
    ["math_bounds"] = 0,
    ["math_delimiters"] = 0,
    ["math_fracs"] = 0,
    ["math_super_sub"] = 0,
    ["math_symbols"] = 0,
    ["sections"] = 0,
    ["styles"] = 1
}

g.vimtex_syntax_conceal_disable = 1

cmd [[

autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>b <Plug>(vimtex-compile)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>v <Plug>(vimtex-view)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>c <Plug>(vimtex-clean)

]]
