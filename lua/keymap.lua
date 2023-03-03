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
vim.keymap.set("", "<A-1>", "1gt")
vim.keymap.set("", "<A-2>", "2gt")
vim.keymap.set("", "<A-3>", "3gt")
vim.keymap.set("", "<A-4>", "4gt")
vim.keymap.set("", "<A-5>", "5gt")
vim.keymap.set("", "<A-6>", "6gt")
vim.keymap.set("", "<A-7>", "7gt")
vim.keymap.set("", "<A-8>", "8gt")
vim.keymap.set("", "<A-9>", "9gt")
-- Last tab
vim.keymap.set("", "<A-0>", "<cmd>tablast<cr>")

-- Last buffer
vim.keymap.set("", "<leader><tab>", "<cmd>b# <cr>")

-- no highlight
vim.keymap.set("n", "<leader>n", "<cmd>noh<cr>")

-- remap manual
vim.keymap.set("n", "<S-k>", "<Nop>")

-- terminal
-- vim.keymap.set("t", "<esc>", "<C-\\><C-N>")
vim.keymap.set("t", "jj", "<C-\\><C-N>")

-- Disable command line history window
vim.keymap.set("n", "q", "<nop>") -- conflicted with other setting close for now
vim.keymap.set("v", "q", "<nop>")

vim.keymap.set("n", "K", "<nop>")
vim.keymap.set("v", "K", "<nop>")

-- Delete trailing spaces
vim.keymap.set("n", "<A-F>", "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><cr>")

vim.keymap.set("", "c", '"_c')
vim.keymap.set("", "C", '"_C')

-- Prevent typo
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf", "help", "git", "gitcommit", "spectre_panel" },
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
		})
	end,
})
