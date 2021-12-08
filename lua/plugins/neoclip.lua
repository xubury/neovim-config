require("telescope").load_extension("neoclip")
require("neoclip").setup()
local u = require("utils")

u.map("n", "<space>y", '<cmd>Telescope neoclip " extra=+,*<cr>')
