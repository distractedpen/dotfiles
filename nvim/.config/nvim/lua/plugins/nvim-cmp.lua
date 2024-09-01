local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    vim.notify("Failed to load nvim-cmp", vim.log.levels.ERROR)
    return
end

local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then
    vim.notify("Failed to load luasnip", vim.log.levels.ERROR)
    return
end

-- Setup 
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    -- Load snippet support
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- Completion settings
    completion = {
        completeopt = 'menu,menuone',
        keyword_length = 2
    },

    -- Keymapping
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-h>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),

    -- Load Sources
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = "cmp_r" },
        -- { name = 'friendly_snippit' },
}, {
        { name = 'buffer' },
    }),
})
