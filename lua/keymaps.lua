local u = require("utils")

-- Clipboard keymaps
-- CTRL-X and SHIFT-Del are Cut
u.map("v", "<C-X>", '"+x')
u.map("v", "<S-Del>", '"+x')

-- CTRL-C and CTRL-Insert are Copy
u.map("v", "<C-C>", '"+y')
u.map("v", "<C-insert>", '"+y')

-- CTRL-V and SHIFT-Insert are Paste
u.map("", "<C-V>", '"+p')
u.map("", "<C-insert>", '"+p')
u.map("i", "<C-V>", '<C-R>+')
u.map("i", "<C-insert>", '<C-R>+')
u.map("c", "<C-V>", "<C-R>+")
u.map("c", "<S-Insert>", "<C-R>+")

-- Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
-- using completions).
u.map("", "<C-S>", ":update<CR>")
u.map("v", "<C-S>", "<C-C>:update<CR>")
u.map("i", "<C-S>", "<Esc>:update<CR>gi")

-- Esc
u.map("i", "jj", "<Esc>")

-- Last insert tag
u.map("n", "gi", "`^")
-- Tag
u.map("n", "t", "`")

-- Go to tab by number
u.map("", "<leader>1", "1gt")
u.map("", "<leader>2", "2gt")
u.map("", "<leader>3", "3gt")
u.map("", "<leader>4", "4gt")
u.map("", "<leader>5", "5gt")
u.map("", "<leader>6", "6gt")
u.map("", "<leader>7", "7gt")
u.map("", "<leader>8", "8gt")
u.map("", "<leader>9", "9gt")
-- Last tab
u.map("", "<leader>0", ":tablast<cr>")

-- Last buffer
u.map("", "<space><tab>", ":b# <cr>")
-- Delete buffer
u.map("", "<space>w", ":bp<cr>:bd #<cr>")

-- no hightlight
u.map("n", "<leader>n", ":noh<cr>")

-- remap manual
u.map("n", "<S-k>", "<Nop>")

-- terminal
u.map("t", "<esc>", "<C-\\><C-N>")
