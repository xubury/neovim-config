local g = vim.g

g.vim_markdown_math = 1
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function(event)
		vim.keymap.set("n", "<leader>v", "<Plug>MarkdownPreviewToggle", {
			buffer = event.buf,
			silent = true,
		})
	end,
})
