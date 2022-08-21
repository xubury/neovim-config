-- Clipboard keymaps
-- CTRL-X and SHIFT-Del are Cut
vim.keymap.set("v", "<C-X>", '"+x')
vim.keymap.set("v", "<S-Del>", '"+x')

-- CTRL-C and CTRL-Insert are Copy
vim.keymap.set("v", "<C-C>", '"+y')
vim.keymap.set("v", "<C-insert>", '"+y')

-- CTRL-V and SHIFT-Insert are Paste
vim.keymap.set("", "<C-V>", '"+p')
vim.keymap.set("", "<C-insert>", '"+p')
vim.keymap.set("i", "<C-V>", "<C-R>+")
vim.keymap.set("i", "<C-insert>", "<C-R>+")
vim.keymap.set("c", "<C-V>", "<C-R>+")
vim.keymap.set("c", "<S-Insert>", "<C-R>+")

-- Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
-- using completions).
vim.keymap.set("", "<C-S>", "<cmd>update<cr>")
vim.keymap.set("v", "<C-S>", "<C-C>:update<cr>")
vim.keymap.set("i", "<C-S>", "<Esc>:update<cr>gi")

-- Esc
vim.keymap.set("i", "jj", "<Esc>")

-- Goto last insert
vim.keymap.set("n", "ti", "`^")
-- Goto mark
vim.keymap.set("n", "t", "`")

-- Go to tab by number
vim.keymap.set("", "<leader>1", "1gt")
vim.keymap.set("", "<leader>2", "2gt")
vim.keymap.set("", "<leader>3", "3gt")
vim.keymap.set("", "<leader>4", "4gt")
vim.keymap.set("", "<leader>5", "5gt")
vim.keymap.set("", "<leader>6", "6gt")
vim.keymap.set("", "<leader>7", "7gt")
vim.keymap.set("", "<leader>8", "8gt")
vim.keymap.set("", "<leader>9", "9gt")
-- Last tab
vim.keymap.set("", "<leader>0", "<cmd>tablast<cr>")

-- Last buffer
vim.keymap.set("", "<leader><tab>", "<cmd>b# <cr>")

-- no highlight
vim.keymap.set("n", "<leader>n", "<cmd>noh<cr>")

-- remap manual
vim.keymap.set("n", "<S-k>", "<Nop>")

-- terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-N>")
