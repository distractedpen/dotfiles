local builtin = require('telescope.builtin')
local configs = require('telescope.config')

local vimgrep_args = { unpack(configs.values.vimgrep_arguments) }

table.insert(vimgrep_args, "--hidden")
table.insert(vimgrep_args, "--glob")
table.insert(vimgrep_args, "!**/.git/*")

require('telescope').setup({
    defaults = {
        vimgrep_arguments = vimgrep_args,
    },
    pickers = {
        find_files = {
            find_command = {
                "rg", "--files", "--hidden",
                "--glob", "!**/.git/*",
                "--glob", "!**/node_modules/*",
                "--glob", "!**/.venv/*",
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or 'ignore_case' or 'respect_case'
            -- default case is 'smart_case
        },

        ['ui-select'] = {
            require("telescope.themes").get_dropdown {}
        }
    }
})


require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

-- Keybindings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
