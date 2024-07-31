--[[

Neovim init file
Last updated: 9 Dec 2023

--]]

-- Set the python3 provider
vim.g.python3_host_prog = '/home/taylor/.py3nvim/bin/python3'

-- Import Lua modules
require('core/options')
require('core/lazy')
require('plugins/nvim-jdtls')
require('lsp/lspconfig')
require('plugins/nvim-copilot')
require('plugins/nvim-treesitter')
require('plugins/nvim-cmp')
require('plugins/nvim-telescope')
require('plugins/nvim-harpoon')
require('plugins/nvim-neotree')
require('plugins/nvim-image')
require('plugins/nvim-r')
