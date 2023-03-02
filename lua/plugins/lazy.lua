local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme
	{
		"pappasam/papercolor-theme-slim",
		lazy = false,
		config = function()
			require("plugins/papercolor")
		end,
	},

	-- Cursor hop
	{
		"aznhe21/hop.nvim",
		branch = "fix-some-bugs",
		config = function()
			require("plugins/hop")
		end,
	},

	-- Buffer delete
	{
		"ojroques/nvim-bufdel",
		config = function()
			require("plugins/bufdel")
		end,
	},

	-- Window picker
	{
		"s1n7ax/nvim-window-picker",
		version = "v1.*",
		config = function()
			require("plugins/window-picker")
		end,
	},

	-- Neovim plugin to improve the default vim.ui interfaces
	{
		"stevearc/dressing.nvim",
		config = function()
			require("plugins/dressing")
		end,
	},

	-- Intro screen
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins/alpha")
		end,
		cond = false,
	},

	-- Tabline plugin
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins/bufferline")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("plugins/nvim-tree")
		end,
	},
	-- Tmux navigator
	"christoomey/vim-tmux-navigator",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins/nvim-autopairs")
		end,
	},

	-- Delete/change/add parentheses/quotes/XML-tags/much more with ease
	"tpope/vim-surround",

	-- Adds indentation guides to all lines
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins/indentline")
		end,
	},

	-- Commenter
	{
		"preservim/nerdcommenter",
		init = function()
			require("plugins/nerdcommenter")
		end,
	},

	-- Color preview
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins/nvim-colorizer")
		end,
	},

	-- Multi cursor
	"mg979/vim-visual-multi",

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
		config = function()
			require("plugins/lualine")
		end,
	},
	-- Git plugin
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins/gitsigns")
		end,
	},

	"tpope/vim-fugitive",
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins/nvim-telescope")
		end,
	},

	-- Telecope extensions
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		lazy = false,
	},
	"nvim-telescope/telescope-project.nvim",

	-- Find the enemy and replace them with dark power
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins/nvim-spectre")
		end,
	},
	-- Syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("plugins/nvim-treesitter")
		end,
	},

	-- Clipboard manager
	"AckslD/nvim-neoclip.lua",

	-- Mason lsp/dap tool package manager
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"jayp0521/mason-nvim-dap.nvim",
		},
		config = function()
			require("plugins/mason")
		end,
	},

	-- LSP support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins/nvim-lspconfig")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("plugins/lsp_signature")
		end,
	},

	-- LSP complete menu
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("plugins/nvim-cmp")
		end,
	},

	-- LSP outline
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins/symbol-outline")
		end,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		config = function()
			require("plugins/markdown-preview")
		end,
	},

	-- CMake tool
	{
		"Shatur/neovim-tasks",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins/neovim-cmake")
		end,
	},

	-- Visual Debugger
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		commit = "ffe3e589fe2861b5ed0486832b0974e94587ae23",
		config = function()
			require("plugins/nvim-dap")
			require("plugins/adapter")
		end,
	},

	-- my EmmyDeggger
	{
		"xubury/Nvim-EmmyLua",
		build = "npm install && npm run compile && node ./build/prepare-version.js && node ./build/prepare.js",
	},
})
