require("telescope").load_extension("neoclip")
require("neoclip").setup()

vim.keymap.set("n", "<space>y", '<cmd>Telescope neoclip " extra=+,*<cr>')
