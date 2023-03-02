local picker = require("window-picker")
local u = require("util")

vim.keymap.set("n", "<C-P>", function()
	local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

require("window-picker").setup({
    -- fg_color = get_color("@text.literal", "fg#"),

	-- if you have include_current_win == true, then current_win_hl_color will
	-- be highlighted using this background color
    current_win_hl_color = u.get_color("@text.title.h1", "fg#"),

	-- all the windows except the curren window will be highlighted using this
	-- color
	other_win_hl_color = u.get_color("@text.title", "fg#"),
})

