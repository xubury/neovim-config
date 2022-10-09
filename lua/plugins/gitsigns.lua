require("gitsigns").setup({
	current_line_blame = true,
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
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "g[", function()
			if vim.wo.diff then
				return "g["
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "gs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "gu", ":Gitsigns reset_hunk<CR>")
		map("n", "gS", gs.stage_buffer)
		map("n", "gU", gs.reset_buffer)
		map("n", "gs", gs.preview_hunk)
		map("n", "gd", gs.diffthis)
		map("n", "gD", function()
			gs.diffthis("~")
		end)
	end,
})
