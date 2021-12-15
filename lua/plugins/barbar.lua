local u = require("utils")

-- Move to previous/next
u.map("n", "<A-p>", ":BufferPrevious<CR>")
u.map("n", "<A-n>", ":BufferNext<CR>")
-- Re-order to previous/next
u.map("n", "<A-left>", ":BufferMovePrevious<CR>")
u.map("n", "<A-right>", " :BufferMoveNext<CR>")
-- Goto buffer in position...
u.map("n", "<A-1>", ":BufferGoto 1<CR>")
u.map("n", "<A-2>", ":BufferGoto 2<CR>")
u.map("n", "<A-3>", ":BufferGoto 3<CR>")
u.map("n", "<A-4>", ":BufferGoto 4<CR>")
u.map("n", "<A-5>", ":BufferGoto 5<CR>")
u.map("n", "<A-6>", ":BufferGoto 6<CR>")
u.map("n", "<A-7>", ":BufferGoto 7<CR>")
u.map("n", "<A-8>", ":BufferGoto 8<CR>")
u.map("n", "<A-9>", ":BufferGoto 9<CR>")
u.map("n", "<A-0>", ":BufferLast<CR>")
-- Close buffer
u.map("n", "<A-w>", ":BufferClose<CR>")
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
