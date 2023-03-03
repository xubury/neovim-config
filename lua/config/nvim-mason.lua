require("mason").setup()

-- Dap is lazy loaded, so can't really use automatic install
require("mason-nvim-dap").setup({
	ensure_installed = { "cpp" },
})
