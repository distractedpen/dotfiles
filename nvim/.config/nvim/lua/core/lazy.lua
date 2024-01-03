-- Plugin manager configuration file

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim


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
local status_ok, lazy = pcall(require, 'lazy')
 if not status_ok then
     return
 end

-- Start setup
lazy.setup({
    -- Comment
    {
        'numToStr/Comment.nvim',
        config = function()
            require("Comment").setup()
        end,
        lazy = false,
    },

    --[[ -- Ayu Color Scheme
    {
        'Shatur/neovim-ayu',
        config = function()
            require('ayu').setup({
                mirage = true,
                overrides = {},
            })
            require('ayu').colorscheme()
        end,
        lazy = false,
    }, ]]

    -- Catpuccin color Scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
    },

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = 'ayu',
            })
        end,
    },

    -- LSP Server Configuration
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim"},
    { "neovim/nvim-lspconfig"},

    -- Special Java LSP handling
    { "mfussenegger/nvim-jdtls" },

    -- Special C# Handling for Godot
    { "Hoffs/omnisharp-extended-lsp.nvim" },

    -- Nvim Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    -- Harpoon
    { "nvim-lua/plenary.nvim" }, -- don't forget to add this one if you don't have it yet!
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    },

    -- Code Completion nvim-cmp
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp',
        },
    },

    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },


    -- Neodev for code completion inside neovim configuration files
    { 'folke/neodev.nvim', opts = {} },

    -- Telescope Funny Finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    -- Tree File Viewer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        never_show = {
                            ".DS_Store",
                            ".git"
                        },
                    }
                },

            });
        end,
    },

    -- Git Integration
    { 'tpope/vim-fugitive' },

    -- Git Signs for git change highlighting
    { 'lewis6991/gitsigns.nvim' },

    -- Tmux Integration
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    }
})


-- Set the colorscheme
vim.cmd.colorscheme "catppuccin-mocha"
