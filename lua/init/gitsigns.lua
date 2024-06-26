require("gitsigns").setup({
    current_line_blame = false,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "g]", function()
            if vim.wo.diff then
                return "g]"
            end
            vim.schedule(function()
                gs.next_hunk({ navigation_message = false })
            end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "g[", function()
            if vim.wo.diff then
                return "g["
            end
            vim.schedule(function()
                gs.prev_hunk({ navigation_message = false })
            end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "gs", "<cmd>Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "gu", "<cmd>Gitsigns reset_hunk<CR>")
        map("n", "gS", gs.stage_buffer)
        map("n", "gU", gs.reset_buffer)
        map("n", "gs", gs.preview_hunk)
    end,
})
