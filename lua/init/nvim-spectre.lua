vim.keymap.set("n", "<leader>gW", function()
	require("spectre").open()
end)

vim.keymap.set("n", "<leader>gw", function()
	require("spectre").open_file_search()
end)
