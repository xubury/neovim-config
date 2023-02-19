require("bufdel").setup({
	next = "tabs", -- or 'cycle, 'alternate'
	quit = false, -- quit Neovim when last buffer is closed
})

vim.keymap.set("n", "<A-w>", "<cmd>BufDel<cr>")
