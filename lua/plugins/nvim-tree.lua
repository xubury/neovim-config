vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local NTree = require("nvim-tree")

NTree.setup({
	sort_by = "case_sensitive",
    -- sync_root_with_cwd = true,
    respect_buf_cwd = true,
    -- update_focused_file = {
    --     enable = true,
    --     update_root = true,
	-- },
	actions = {
		open_file = {
			resize_window = false,
			window_picker = {
				enable = true,
				picker = require("window-picker").pick_window,
			},
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
