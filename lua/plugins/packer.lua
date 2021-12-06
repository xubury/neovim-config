local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    print("cloning packer into" .. install_path)
    fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
    vim.cmd("packadd packer.nvim")
end

-- Add packages
return require("packer").startup(
    function()
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }

        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }

        -- LSP support
        use "ray-x/lsp_signature.nvim"
        use {
            "ray-x/navigator.lua",
            requires = {
                "neovim/nvim-lspconfig",
                "windwp/nvim-autopairs",
                {"ray-x/guihua.lua", run = "cd lua/fzy && make"}
            }
        }

        -- LSP complete menu
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
                "hrsh7th/vim-vsnip-integ",
                "rafamadriz/friendly-snippets"
            }
        }

        -- Symbol auto surround
        use "tpope/vim-surround"

        -- Autoformat
        use "Chiel92/vim-autoformat"

        -- Markdown preview
        use {
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install"
        }

        -- Tmux navigator
        use "christoomey/vim-tmux-navigator"

        -- Multi cursor
        use "mg979/vim-visual-multi"

        -- Clipboard manager
        use {
            "AckslD/nvim-neoclip.lua",
            config = function()
                require("telescope").load_extension("neoclip")
                require("neoclip").setup()
            end
        }

        -- Color scheme
        use "lifepillar/vim-gruvbox8"

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        -- Emoji
        use "junegunn/vim-emoji"

        -- Signify (Show a diff using Vim its sign column)
        use "mhinz/vim-signify"

        -- Display the indention levels with thin vertical lines
        use "Yggdroot/indentLine"

        -- Latex
        use "lervag/vimtex"

        -- Lua plugins
        use "andrejlevkovitch/vim-lua-format"

        -- CMake
        use {
            "ilyachur/cmake4vim",
            requires = {
                "xubury/toolchains"
            }
        }

        -- For async compile
        use "tpope/vim-dispatch"

        -- Commenter
        use "preservim/nerdcommenter"
    end
)
