require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "vim", "rust", "python", "glsl", "java", "json" },
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
        disable = { "lua", "latex", "javascript", "typescript" },
	},
	additional_vim_regex_highlighting = false,
})
