-- Set the python3 provider
vim.g.python3_host_prog = '/home/cn508857/.py3nvim/bin/python3'

-- Import Lua modules
require('core/options')
require('core/lazy')
require('core/keybindings')
require('lsp/lspconfig')
require('plugins/treesitter')
require('plugins/telescope')
require('plugins/blink')
require('plugins/neodev')
require('plugins/harpoon')
require('plugins/undotree')
require('plugins/dap')
require('plugins/dap-go')
