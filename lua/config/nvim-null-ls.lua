-- null-ls integration
local null_ls = require("null-ls")
null_ls.setup({
	on_attach = require("keymap").on_attach,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.cmake_format,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--tab-width", "4" } }),
	},
})

require("mason-null-ls").setup({
	automatic_installation = true,
})
