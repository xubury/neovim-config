require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "cpp",
        "cmake",
        "vim",
        "rust",
        "python",
        "glsl",
        "java",
        "json",
        "markdown",
        "markdown_inline",
        "c_sharp",
    },
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},
        additional_vim_regex_highlighting = false,
    },
})
