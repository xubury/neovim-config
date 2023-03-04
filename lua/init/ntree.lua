vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<C-b>", function()
	require("nvim-tree").toggle(true)
end)
