local actions = require("telescope.actions")
require("telescope").setup({
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

require("telescope").load_extension("fzf")

-- keymap
local telescope_project_files = function()
	local opts = {  } -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

vim.keymap.set("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>ff", telescope_project_files)
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fn", "<cmd>ene <BAR> startinsert<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", ";", "<cmd>Telescope<cr>")
