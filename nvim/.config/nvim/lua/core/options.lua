-- General Neovim settings and configuration
local g = vim.g            -- Global variable
local opt = vim.opt        -- Set options (global/buffer/windows-scoped)options

-- General
opt.mouse = 'a'                        -- Enable mouse support
opt.clipboard = "unnamed,unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false                   -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'   -- Autocomplete options

-- Neovim UI
opt.number = true                      -- Show line numbers
opt.showmatch = true                   -- Show matching parenthesis
opt.foldmethod = 'marker'              -- Enable folding (default 'foldmarker')
opt.splitright = true                  -- vertical split to the right
opt.splitbelow = true                  -- Horizontal split to the bottom
opt.ignorecase = true                  -- Ignore case letters when search
opt.smartcase = true                   -- Ignore lowercase for the whole pattern
opt.linebreak = true                   -- wrap on word boundary
opt.termguicolors = true               -- Enable 24-bit RGB colors
opt.laststatus = 3                     -- Set global status line
opt.relativenumber = true              -- Use relative numberings
opt.textwidth = 80
opt.cc="+1"                            -- set a vert bar at 80 characters

-- Tabs, indents
opt.expandtab = true                   -- Use spaces instead of tabs
opt.shiftwidth = 4                     -- Shift 4 spaces when tab
opt.tabstop = 4                        -- 1 tab == 4 spaces
opt.smartindent = true                 -- Autoindent new lines

-- Memory, CPU
opt.hidden = true                      -- Enable background buffers
opt.history = 120                      -- remember N lines in history
opt.lazyredraw = true                  -- faster scrolling
opt.synmaxcol = 240                    -- max columns for syntax highlighting
opt.updatetime = 250                   -- ms to wait for triggering an event

-- Keybindings
g.mapleader = ','
g.maplocalleader = ','

-- Startup
-- Disable nvim intro
opt.shortmess:append "sI"


-- custom keybindings
vim.keymap.set("n", "<leader><F12>", ":set hlsearch! hlsearch?<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")



-- -- Disable builtin pluings
local disabled_built_ins = {
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

