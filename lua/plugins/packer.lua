local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    print("cloning packer into" .. install_path)
    packer_bootstrap =
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- Add packages
return require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"

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
        use "AckslD/nvim-neoclip.lua"

        -- Colorscheme
        -- use "morhetz/gruvbox"
        use {
            "eddyekofo94/gruvbox-flat.nvim"
        }

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }

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
                "tpope/vim-dispatch",
                "xubury/toolchains"
            }
        }

        -- Commenter
        use "preservim/nerdcommenter"

        -- Tabline plugin
        use {
            "romgrk/barbar.nvim",
            requires = {"kyazdani42/nvim-web-devicons"}
        }

        -- File explorer
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons" -- optional, for file icon
            }
        }

        -- Color preview
        use "norcalli/nvim-colorizer.lua"

        if packer_bootstrap then
            require("packer").sync()
        end
    end
)
