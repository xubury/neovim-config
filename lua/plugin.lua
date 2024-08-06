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
                "spellfile",
                "rplugin",
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
        "smoka7/hop.nvim",
        -- branch = "fix-some-bugs",
        init = function()
            require("init/nvim-hop")
        end,
        config = function()
            require("config/nvim-hop")
        end,
        lazy = true,
    },

    {
        "jesseleite/vim-noh",
        event = "VeryLazy",
    },

    -- Buffer delete
    {
        "famiu/bufdelete.nvim",
        init = function()
            require("init/nvim-bufdelete")
        end,
        lazy = true,
    },

    -- Window picker
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        version = "v2.*",
        init = function()
            require("init/nvim-window-picker")
        end,
        config = function()
            require("config/nvim-window-picker")
        end,
        event = "VeryLazy",
        lazy = true,
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
    { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("config/nvim-autopairs")
        end,
        event = "VeryLazy",
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({})
        end,
        event = "VeryLazy",
    },

    -- Multi cursor
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_silent_exit = 1
            vim.g.VM_quit_after_leaving_insert_mode = 1
            vim.g.VM_show_warnings = 0
        end,
        event = "VeryLazy",
    },

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
        dependencies = {},
        config = function()
            require("config/lualine")
        end,
    },
    {
        "folke/noice.nvim",
        commit = "b3f08e6",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("config/nvim-noice")
        end,
    },

    --------------* Git Related Plugin 	*--------------
    -- Show git signs in nvim
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            require("init/gitsigns")
        end,
        event = "VeryLazy",
    },
    -- Run git command in nvim
    { "tpope/vim-fugitive", event = "VeryLazy" },

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
            "nvim-telescope/telescope-ui-select.nvim",
        },
        init = function()
            require("init/nvim-telescope")
        end,
        config = function()
            require("config/nvim-telescope")
        end,
        event = "VeryLazy",
    },

    -- Telecope extensions
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        lazy = true,
    },

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
            "williamboman/mason.nvim",
        },
        lazy = true,
    },

    {
        "nvimdev/guard.nvim",
        dependencies = {
            "nvimdev/guard-collection",
        },
        init = function()
            require("init/nvim-guard")
        end,
        config = function()
            require("config/nvim-guard")
        end,
        lazy = true,
    },

    --------------* LSP Related Plugin *--------------
    -- LSP support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
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
        "hedyhli/outline.nvim",
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
        tag = "v0.9.2",
        build = ":TSUpdate",
        config = function()
            require("config/nvim-treesitter")
        end,
        event = "VeryLazy",
    },

    --------------* DAP Related Plugin *--------------
    -- Visual Debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
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

    {
        "xubury/emmylua.nvim",
        build = "npm install && npm run compile && node ./build/prepare-version.js && node ./build/prepare.js",
        lazy = true,
    },

    --------------* Terminal Plugin *--------------
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        init = function()
            require("init/nvim-toggleterm")
        end,
        config = function()
            require("config/nvim-toggleterm")
        end,
        lazy = true,
    },

    --------------* Disabled Plugin *--------------
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
