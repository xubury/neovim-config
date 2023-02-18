vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local NTree = require("nvim-tree")

NTree.setup({
	sort_by = "case_sensitive",
	actions = {
		open_file = {
			resize_window = false,
		},
	},
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "<F2>", action = "rename" },
				{ key = "<cr>", action = "cd" },
			},
		},
	},
})

vim.keymap.set("n", "<C-b>", function()
	NTree.toggle(true, true)
end)
