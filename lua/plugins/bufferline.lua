require("bufferline").setup({
	options = {
		numbers = "buffer_id",
	},
})
vim.keymap.set("n", "<A-p>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<A-n>", "<cmd>BufferLineCycleNext<CR>")
