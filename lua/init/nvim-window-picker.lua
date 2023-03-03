vim.keymap.set("n", "<C-P>", function()
	local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })
