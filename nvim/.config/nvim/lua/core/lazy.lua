-- Plugin manager configuration file

-- Plugin manager: lazy.nvim URL: https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim
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

-- use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

-- Start setup
lazy.setup({

    -- Shortcut to comment out lines
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
        lazy = false,
    },

    -- Catpuccin color Scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
                require("catppuccin").setup({
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
            })
        end
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = "catppuccin",
            })
        end,
    },

    -- LSP Server Configuration
    { "rafamadriz/friendly-snippets" },
    { "saghen/blink.cmp", 
     dependencies = { "rafamadriz/friendly-snippets" },
     version = "*",
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" }
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release. version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- Neodev for code completion inside neovim configuration files
    { 
        "folke/neodev.nvim",
        opts = {} 
    },

    -- FORMATTERS
    { "wesleimp/stylua.nvim" },
    {
        "creativenull/efmls-configs-nvim",
        version = "v1.x.x",
        dependencies = { "neovim/nvim-lspconfig" },
    },

    -- Nvim Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- Harpoon
    { "nvim-lua/plenary.nvim" },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } },
    },


    -- Telescope Funny Finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    -- Telescope UI select
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Git Integration
    { "tpope/vim-fugitive" },
    -- Git Signs for git change highlighting
    { "lewis6991/gitsigns.nvim" },

    -- Tmux Integration
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp", "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- Nvim Surround
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Oil.nvim File Explorer Buffer
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }


})

vim.cmd.colorscheme("catppuccin")
