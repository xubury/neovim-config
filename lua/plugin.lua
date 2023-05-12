local opt = {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tutor",
				"netrwPlugin",
				"zipPlugin",
				"tarPlugin",
				"tohtml",
			},
		},
	},
}

local plugins = {
	-- Colorscheme
	{
        "felipeagc/fleet-theme-nvim",
		priority = 1000,
		config = function()
			require("config/colorscheme")
		end,
	},

	-- Cursor hop
	{
		"aznhe21/hop.nvim",
		branch = "fix-some-bugs",
		init = function()
			require("init/nvim-hop")
		end,
		config = function()
			require("config/nvim-hop")
		end,
		lazy = true,
	},

	-- Buffer delete
	{
		"ojroques/nvim-bufdel",
		init = function()
			require("init/nvim-bufdel")
		end,
		config = function()
			require("config/nvim-bufdel")
		end,
		lazy = true,
	},

	-- Window picker
	{
		"s1n7ax/nvim-window-picker",
		version = "v1.*",
		init = function()
			require("init/nvim-window-picker")
		end,
		config = function()
			require("config/nvim-window-picker")
		end,
		lazy = true,
	},

	-- Neovim plugin to improve the default vim.ui interfaces
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config/nvim-dressing")
		end,
		event = "VeryLazy",
	},

	-- Tabline plugin
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
		init = function()
			require("init/nvim-bufferline")
		end,
		config = function()
			require("config/nvim-bufferline")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icon
			"s1n7ax/nvim-window-picker",
		},
		init = function()
			require("init/ntree")
		end,
		config = function()
			require("config/ntree")
		end,
		event = "VeryLazy",
	},

	-- Tmux navigator
	"christoomey/vim-tmux-navigator",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("config/nvim-autopairs")
		end,
		event = "VeryLazy",
	},

	-- Delete/change/add parentheses/quotes/XML-tags/much more with ease
	{ "tpope/vim-surround", event = "VeryLazy" },

	-- Multi cursor
	{ "mg979/vim-visual-multi", event = "VeryLazy" },

	-- Commenter
	{
		"preservim/nerdcommenter",
		init = function()
			require("init/nerdcommenter")
		end,
		event = "VeryLazy",
	},

	-- Color preview
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("config/nvim-colorizer")
		end,
		event = "VeryLazy",
	},

	-- Easy find/replace
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			require("init/nvim-spectre")
		end,
		lazy = true,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		init = function()
			require("init/markdown-preview")
		end,
		ft = "markdown",
	},

	-- CMake tool
	{
		"xubury/neovim-tasks",
		branch = "rundir",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jayp0521/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("config/neovim-tasks")
		end,
		init = function()
			require("init/neovim-tasks")
		end,
		cmd = { "Task" },

		lazy = true,
	},

	--------------* Git Related Plugin 	*--------------
	-- Show git signs in nvim
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config/gitsigns")
		end,
		event = "VeryLazy",
	},
	-- Run git command in nvim
	{ "tpope/vim-fugitive" },

	--------------* Git Related Plugin 	*--------------

	--------------* Telescope Related Plugin *--------------
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"AckslD/nvim-neoclip.lua",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		init = function()
			require("init/nvim-telescope")
		end,
		config = function()
			require("config/nvim-telescope")
		end,
		lazy = true,
	},

	-- Telecope extensions
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		lazy = true,
	},
	--------------* Telescope Related Plugin *--------------

	--------------* Mason Related Plugin *--------------
	-- Mason lsp/dap tool package manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("config/nvim-mason")
		end,
		cmd = { "Mason", "MasonInsall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		lazy = true,
	},

	-- Mason dap
	{
		"jayp0521/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		lazy = true,
	},

	-- Mason null-ls
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
		},
		lazy = true,
	},
	--------------* Mason Related Plugin *--------------

	--------------* LSP Related Plugin *--------------
	-- LSP support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim", -- mason-lspconfig need to load before lspconfig
			"williamboman/mason.nvim",
		},

		config = function()
			require("config/nvim-lspconfig")
		end,
		event = "VeryLazy",
	},

	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",

		config = function()
			require("config/nvim-null-ls")
		end,

		event = "VeryLazy",
	},

	-- LSP signature
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("config/nvim-lsp_signature")
		end,
		event = "VeryLazy",
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
			require("config/nvim-cmp")
		end,
		lazy = true,
	},

	-- LSP outline
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("config/nvim-symbols-outline")
		end,
		init = function()
			require("init/nvim-symbols-outline")
		end,
		lazy = true,
	},
	-- Syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config/nvim-treesitter")
		end,
		event = "VeryLazy",
	},
	--------------* LSP Related Plugin *--------------

	--------------* DAP Related Plugin *--------------
	-- Visual Debugger
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("config/adapter")
			require("config/nvim-dapui")
		end,
		init = function()
			require("init/nvim-dap")
		end,
		commit = "ffe3e589fe2861b5ed0486832b0974e94587ae23",
		lazy = true,
	},

	-- My EmmyDeggger
	{
		"xubury/Nvim-EmmyLua",
		build = "npm install && npm run compile && node ./build/prepare-version.js && node ./build/prepare.js",
		lazy = true,
	},
	--------------* DAP Related Plugin *--------------

	--------------* Disabled Plugin *--------------

	-- Adds indentation guides to all lines
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config/indentline")
		end,
		enabled = false,
	},

	-- Git plugin (Some features are not working correctly, disabled for now.)
	{
		"TimUntersberger/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("neogit").setup()
		end,
		enabled = false,
	},
	--------------* Disable Plugin *--------------
}

------------ lazy.nvim bootstrap ------------
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
------------ lazy.nvim bootstrap ------------

require("lazy").setup(plugins, opt)
