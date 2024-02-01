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
        "catppuccin/nvim",
        name = "catppuccin",
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
        name = "window-picker",
        event = "VeryLazy",
        version = "v2.*",
        init = function()
            require("init/nvim-window-picker")
        end,
        config = function()
            require("config/nvim-window-picker")
        end,
    },

    -- Neovim plugin to improve the default vim.ui interfaces
    {
        "stevearc/dressing.nvim",
        config = function()
            require("config/nvim-dressing")
        end,
        event = "VeryLazy",
    },

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        event = "VeryLazy",
        lazy = true,
        config = function()
            require("config/neo-tree")
        end,
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

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config/lualine")
        end,
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
    },
    -- Run git command in nvim
    { "tpope/vim-fugitive" },

    --------------* Git Related Plugin 	*--------------

    --------------* Telescope Related Plugin *--------------
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
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

    -- Unreal engine support
    {
        "xubury/Unreal.nvim",
        config = function()
            -- local unreal = require("unreal.commands")
            -- print(unreal.LogLevel_Log)
            -- unreal.LogLevel_Log = 5
            vim.g.unrealnvim_loglevel = 5
            vim.g.unrealnvim_debug = true
        end,
        dependencies = {
            "tpope/vim-dispatch",
        },
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
        tag = "v0.9.1",
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
        lazy = true,
    },

    --------------* DAP Related Plugin *--------------

    --------------* Terminal Plugin *--------------
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("config/toggleterm")
        end,
    },
    --------------* Terminal Plugin *--------------

    -- My EmmyDeggger
    {
        "xubury/emmylua.nvim",
        build = "npm install && npm run compile && node ./build/prepare-version.js && node ./build/prepare.js",
        lazy = true,
    },

    --------------* Disabled Plugin *--------------
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
        enabled = false,
    },

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
