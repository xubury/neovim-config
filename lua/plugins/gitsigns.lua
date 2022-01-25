require("gitsigns").setup(
    {
        current_line_blame = true,
        keymaps = {
            noremap = true,
            ["n g]"] = "<cmd>Gitsigns next_hunk<CR>",
            ["n g["] = "<cmd>Gitsigns prev_hunk<CR>",
            ["n gs"] = "<cmd>Gitsigns preview_hunk<CR>",
            ["n gu"] = "<cmd>Gitsigns reset_hunk<CR>",
            ["v gu"] = "<cmd>Gitsigns reset_hunk<CR>",
            ["n gb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>'
        }
    }
)
