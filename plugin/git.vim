set updatetime=100

nnoremap gd <cmd>SignifyDiff<CR>
nnoremap gs <cmd>SignifyHunkDiff<CR>
nnoremap gu <cmd>SignifyHunkUndo<CR>

" hunk jumping
nmap g] <PLUG>(signify-next-hunk)
nmap g[ <PLUG>(signify-prev-hunk)
