local u = require("utils")
u.map("n", "gd", "<cmd>SignifyDiff<cr>")
u.map("n", "gs", "<cmd>SignifyHunkDiff<cr>")
u.map("n", "gu", "<cmd>SignifyHunkUndo<cr>")

-- hunk jumping (TODO: not working)
u.map("n", "g]", "<plug>(signify-next-hunk)")
u.map("n", "g[", "<plug>(signify-prev-hunk)")
