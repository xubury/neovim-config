require("nvim-tree") .setup({
	filters = { custom = { ".git" } },
	sort_by = "case_sensitive",
	sync_root_with_cwd = true,
	-- respect_buf_cwd = true,
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
				{ key = "e", action = "" },
				{ key = "u", action = "dir_up" },
				{ key = "<F2>", action = "rename_basename" },
				{ key = "<cr>", action = "cd" },
				{ key = "B", action = "" },
				{ key = "E", action = "" },
				{ key = "bmv", action = "" },
			},
		},
	},
})

