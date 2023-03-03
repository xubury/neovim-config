vim.keymap.set("n", "<leader>S", function()
	require("spectre").open()
end)

vim.keymap.set("n", "<leader>s", function()
	require("spectre").open_file_search()
end)
