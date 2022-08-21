local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
g.tex_flavor = "latex"

if fn.executable("SumatraPDF") > 0 then
	g.vimtex_view_general_viewer = "SumatraPDF"
elseif fn.executable("zathura") > 0 then
	g.vimtex_view_general_viewer = "zathura"
end

g.vimtex_syntax_conceal_disable = 1

cmd([[
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>b <Plug>(vimtex-compile)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>v <Plug>(vimtex-view)
autocmd FileType tex autocmd BufEnter <buffer> nmap <leader>c <Plug>(vimtex-clean)
]])
