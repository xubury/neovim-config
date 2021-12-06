local g = vim.g
local cmd = vim.cmd

g.vim_markdown_math = 1

cmd [[autocmd FileType markdown nmap <leader>v <Plug>MarkdownPreviewToggle]]
