local cmd = vim.cmd
vim.o.background = "dark"
cmd("colorscheme PaperColorSlim")

cmd
[[
augroup custom_papercolorslim_transparent_background
  autocmd!
  autocmd ColorScheme PaperColorSlim highlight Normal guibg=none
augroup end
]]


