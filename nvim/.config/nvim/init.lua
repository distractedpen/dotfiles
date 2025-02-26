--[[

Neovim init file
Last updated: 25 Dec 2024

--]]

-- Set the python3 provider
vim.g.python3_host_prog = '/home/taylor/.py3nvim/bin/python3'

-- Import Lua modules
require('core/options')
require('core/lazy')
require('lsp/lspconfig')
require('plugins/nvim-dap')
require('plugins/nvim-dap-go')
require('plugins/nvim-oil')
require('plugins/nvim-neodev')
require('plugins/nvim-blink')
require('plugins/nvim-treesitter')
require('plugins/nvim-telescope')
require('plugins/nvim-harpoon')
require('plugins/nvim-neotree')
require('plugins/nvim-undotree')
