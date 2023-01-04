local hop = require("hop")
local directions = require("hop.hint").HintDirection
local positions = require("hop.hint").HintPosition

hop:setup()

vim.keymap.set("", "<leader>e", function()
	hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_position = positions.END })
end)
vim.keymap.set("", "<leader>E", function()
	hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_position = positions.END })
end)

vim.keymap.set("", "<leader>w", function()
	hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = true })
end)
vim.keymap.set("", "<leader>W", function()
	hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>b", function()
	hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end)
vim.keymap.set("", "<leader>B", function()
	hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>j", function()
	hop.hint_vertical({ direction = directions.AFTER_CURSOR })
end)
vim.keymap.set("", "<leader>J", function()
	hop.hint_vertical()
end)

vim.keymap.set("", "<leader>k", function()
	hop.hint_vertical({ direction = directions.BEFORE_CURSOR })
end)

vim.keymap.set("", "<leader>l", function()
	hop.hint_lines()
end)
