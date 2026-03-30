return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'dcampos/nvim-snippy',
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>']     = cmp.mapping.scroll_docs(-4),
                ['<C-d>']     = cmp.mapping.scroll_docs(4),
                ['<C-p>']     = cmp.mapping.select_prev_item(),
                ['<C-n>']     = cmp.mapping.select_next_item(),
                ['<CR>']      = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_next_item()
                    else fallback() end
                end, { 'i', 'c', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_prev_item()
                    else fallback() end
                end, { 'i', 'c', 's' }),
            }),
            snippet = {
                expand = function(args)
                    require('snippy').expand_snippet(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'snippy' },
            }),
        })
    end,
}
