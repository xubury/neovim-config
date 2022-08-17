local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    print("cloning packer into " .. install_path)
    packer_bootstrap =
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

local packer = require("packer")
-- Add packages
return packer.startup(
    function(use)
        use "wbthomason/packer.nvim"

        use "stevearc/dressing.nvim"

        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }

        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        }

        use "simrat39/symbols-outline.nvim"

        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }

        -- LSP support
        use {
            "neovim/nvim-lspconfig",
            requires = {
                "williamboman/nvim-lsp-installer",
                "ray-x/lsp_signature.nvim"
            }
        }


        -- LSP complete menu
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
                "hrsh7th/vim-vsnip-integ",
                "rafamadriz/friendly-snippets"
            }
        }

        use "windwp/nvim-autopairs"

        -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
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
        use "eddyekofo94/gruvbox-flat.nvim"

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            requires = {
                "kyazdani42/nvim-web-devicons",
                "arkav/lualine-lsp-progress",
                opt = true
            }
        }

        -- Git plugin
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }

        -- Display the indention levels with thin vertical lines
        use "lukas-reineke/indent-blankline.nvim"

        -- Latex
        use "lervag/vimtex"

        use {
                "xubury/neovim-cmake",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "mfussenegger/nvim-dap"
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

        -- Visual Debugger
        use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}

        -- Intro screen
        use "goolord/alpha-nvim"

        if packer_bootstrap then
            require("packer").sync()
        end
    end
)
