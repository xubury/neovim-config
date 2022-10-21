-- CTRL-X Cut
vim.keymap.set("v", "<C-X>", '"+x')

-- CTRL-C Copy
vim.keymap.set("v", "<C-c>", '"+y')

-- CTRL-V Paste
vim.keymap.set("n", "<C-v>", "p", { remap = true })
vim.keymap.set("v", "<C-v>", "p", { remap = true })
vim.keymap.set("i", "<C-v>", "<C-R>+")
vim.keymap.set("c", "<C-v>", "<C-R>+")

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

-- Disable command line history window
vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("v", "q:", "<nop>")


vim.keymap.set("n", "K", "<nop>")
vim.keymap.set("v", "K", "<nop>")

vim.keymap.set("n", "<A-F>", "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><cr>")
