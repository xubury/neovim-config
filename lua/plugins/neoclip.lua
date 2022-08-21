require("telescope").load_extension("neoclip")
require("neoclip").setup()

vim.keymap.set("n", "<leader>y", '<cmd>Telescope neoclip " extra=+,*<cr>')
