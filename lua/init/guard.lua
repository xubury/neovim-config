vim.keymap.set("n", "<A-F>", function() require("guard.format").do_fmt() end, { noremap = true, silent = true })
