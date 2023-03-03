local u = require("util")

require("window-picker").setup({
	-- fg_color = get_color("@text.literal", "fg#"),

	-- if you have include_current_win == true, then current_win_hl_color will
	-- be highlighted using this background color
	current_win_hl_color = u.get_color("@text.title.h1", "fg#"),

	-- all the windows except the curren window will be highlighted using this
	-- color
	other_win_hl_color = u.get_color("@text.title", "fg#"),
})
