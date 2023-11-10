vim.keymap.set("", "<leader>e", function()
    local hop = require("hop")
    local hint = require("hop.hint")
    hop.hint_words({
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_position = require("hop.hint").HintPosition.END,
    })
end)
vim.keymap.set("", "<leader>E", function()
    local hint = require("hop.hint")
    require("hop").hint_words({
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = false,
        hint_position = hint.HintPosition.END,
    })
end)

vim.keymap.set("", "<leader>ge", function()
    local hint = require("hop.hint")
    require("hop").hint_words({
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_position = hint.HintPosition.END,
    })
end)
vim.keymap.set("", "<leader>gE", function()
    local hint = require("hop.hint")
    require("hop").hint_words({
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = false,
        hint_position = hint.HintPosition.END,
    })
end)

vim.keymap.set("", "<leader>w", function()
    local hint = require("hop.hint")
    require("hop").hint_words({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
end)

vim.keymap.set("", "<leader>W", function()
    local hint = require("hop.hint")
    require("hop").hint_words({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>b", function()
    local hint = require("hop.hint")
    require("hop").hint_words({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
end)

vim.keymap.set("", "<leader>B", function()
    local hint = require("hop.hint")
    require("hop").hint_words({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>j", function()
    local hint = require("hop.hint")
    require("hop").hint_vertical({ direction = hint.HintDirection.AFTER_CURSOR })
end)

vim.keymap.set("", "<leader>J", function()
    require("hop").hint_vertical()
end)

vim.keymap.set("", "<leader>k", function()
    local hint = require("hop.hint")
    require("hop").hint_vertical({ direction = hint.HintDirection.BEFORE_CURSOR })
end)

vim.keymap.set("", "<leader>gg", function()
    require("hop").hint_lines()
end)

vim.keymap.set("", "s", function()
    local hint = require("hop.hint")
    require("hop").hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = false })
end)

vim.keymap.set("", "<leader>s", function()
    local hint = require("hop.hint")
    require("hop").hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = false })
end)
