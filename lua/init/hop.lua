vim.keymap.set("", "<leader>e", function()
	require("hop").hint_words({
		direction = require("hop.hint").HintDirection.AFTER_CURSOR,
		current_line_only = true,
		hint_position = require("hop.hint").HintPosition.END,
	})
end)
vim.keymap.set("", "<leader>E", function()
	require("hop").hint_words({
		direction = require("hop.hint").HintDirection.AFTER_CURSOR,
		current_line_only = false,
		hint_position = require("hop.hint").HintPosition.END,
	})
end)

vim.keymap.set("", "<leader>ge", function()
	require("hop").hint_words({
		direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
		current_line_only = true,
		hint_position = require("hop.hint").HintPosition.END,
	})
end)
vim.keymap.set("", "<leader>gE", function()
	require("hop").hint_words({
		direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
		current_line_only = false,
		hint_position = require("hop.hint").HintPosition.END,
	})
end)

vim.keymap.set("", "<leader>w", function()
	require("hop").hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })
end)
vim.keymap.set("", "<leader>W", function()
	require("hop").hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>b", function()
	require("hop").hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })
end)
vim.keymap.set("", "<leader>B", function()
	require("hop").hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>j", function()
	require("hop").hint_vertical({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
end)
vim.keymap.set("", "<leader>J", function()
	require("hop").hint_vertical()
end)

vim.keymap.set("", "<leader>k", function()
	require("hop").hint_vertical({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
end)

vim.keymap.set("", "<leader>gg", function()
	require("hop").hint_lines()
end)
