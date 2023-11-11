vim.keymap.set("n", "<leader>rW", function()
	require("spectre").open()
end)

vim.keymap.set("n", "<leader>rw", function()
	require("spectre").open_file_search()
end)
