local telescope_project_files = function()
	local builtin = require("telescope.builtin")
	local opts = { show_untracked = true } -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files()
	end
end
local telescope_project = function()
	require("telescope").extensions.project.project({})
end

vim.keymap.set("n", "<C-f>", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>ff", telescope_project_files)
vim.keymap.set("n", "<leader>fp", telescope_project)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>fn", "<cmd>ene <BAR> startinsert<cr>")
vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>y", require("telescope").extensions.neoclip.default)
