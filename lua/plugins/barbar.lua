-- Move to previous/next
vim.keymap.set("n", "<A-p>", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<A-n>", "<cmd>BufferNext<CR>")
-- Re-order to previous/next
vim.keymap.set("n", "<A-left>", "<cmd>BufferMovePrevious<CR>")
vim.keymap.set("n", "<A-right>", "<cmd>BufferMoveNext<CR>")
-- Goto buffer in position...
vim.keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<CR>")
vim.keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<CR>")
vim.keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<CR>")
vim.keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<CR>")
vim.keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<CR>")
vim.keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<CR>")
vim.keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<CR>")
vim.keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<CR>")
vim.keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<CR>")
vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<CR>")
-- Close buffer
vim.keymap.set("n", "<A-w>", "<cmd>BufferClose<CR>")
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
