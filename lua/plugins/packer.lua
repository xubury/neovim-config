local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	print("cloning packer into " .. install_path)
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

local packer = require("packer")
-- Add packages
return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use("eddyekofo94/gruvbox-flat.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("rebelot/kanagawa.nvim")

	-- Neovim plugin to improve the default vim.ui interfaces
	use("stevearc/dressing.nvim")
	use("rcarriga/nvim-notify")

	-- Intro screen
	use("goolord/alpha-nvim")

	-- Tabline plugin
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	-- Tmux navigator
	use("christoomey/vim-tmux-navigator")

	use("windwp/nvim-autopairs")
	-- Delete/change/add parentheses/quotes/XML-tags/much more with ease
	use("tpope/vim-surround")

	-- Adds indentation guides to all lines
	use("lukas-reineke/indent-blankline.nvim")

	-- Commenter
	use("preservim/nerdcommenter")

	-- Color preview
	use("norcalli/nvim-colorizer.lua")

	-- Multi cursor
	use("mg979/vim-visual-multi")

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
			opt = true,
		},
	})

	-- Git plugin
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use("tpope/vim-fugitive")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- Find the enemy and replace them with dark power
	use({
		"nvim-pack/nvim-spectre",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Clipboard manager
	use("AckslD/nvim-neoclip.lua")

	-- Portable package manager for Neovim that runs everywhere Neovim runs.
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("jayp0521/mason-nvim-dap.nvim")

	-- LSP support
	use("neovim/nvim-lspconfig")
	use("ray-x/lsp_signature.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	-- LSP complete menu
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
			"rafamadriz/friendly-snippets",
		},
	})

	use("simrat39/symbols-outline.nvim")

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
	})

	-- Latex
	use("lervag/vimtex")

	-- CMake
	use({
		"Shatur/neovim-cmake",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Visual Debugger
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
