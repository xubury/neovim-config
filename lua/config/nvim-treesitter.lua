require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "cmake", "vim", "rust", "python", "glsl", "java", "json", "markdown", "markdown_inline" },
	ignore_install = {}, -- List of parsers to ignore installing
	indent = { enable = true },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {},
	},
	additional_vim_regex_highlighting = false,
})
