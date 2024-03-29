vim.keymap.set("n", "<A-w>", function()
    require("bufdelete").bufdelete(0, true)
end)
