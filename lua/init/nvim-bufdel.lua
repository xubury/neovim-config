vim.keymap.set("n", "<A-w>", function()
	require("bufdel").delete_buffer_expr("", "<bang>" == "!")
end)
