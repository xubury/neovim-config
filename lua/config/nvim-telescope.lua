local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	defaults = {
		preview = {
			timeout = 500,
		},
		mappings = {
			i = {
				["<Tab>"] = actions.move_selection_worse,
				["<S-Tab>"] = actions.move_selection_better,
				["<C-v>"] = { "<C-r>+", type = "command" },
			},
			n = {
				["<Tab>"] = actions.move_selection_worse,
				["<S-Tab>"] = actions.move_selection_better,
				["<C-v>"] = { "<C-r>+", type = "command" },
			},
		},
	},
})

require("neoclip").setup({
	default_register = { '"', "+", "*" },
})

telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("neoclip")
telescope.load_extension("file_browser")
