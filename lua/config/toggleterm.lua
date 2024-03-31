vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>")

require("toggleterm").setup({
    shell = "pwsh",
})
