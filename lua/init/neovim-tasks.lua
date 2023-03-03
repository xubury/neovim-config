vim.keymap.set("n", "<leader>c", function() require("tasks").start("cmake", "build") end)
vim.keymap.set("n", "<leader>r", function() require("tasks").start("cmake", "run") end)
vim.keymap.set("n", "<leader>d", function() require("tasks").start("cmake", "debug") end)
