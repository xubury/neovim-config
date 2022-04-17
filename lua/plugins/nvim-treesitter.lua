require("nvim-treesitter.configs").setup {
    ensure_installed = {"c", "cpp", "vim", "lua", "rust", "python", "glsl", "java", "json"},
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {"latex"} -- list of language that will be disabled
    }
}
