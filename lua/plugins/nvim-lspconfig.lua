return { -- LSP
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        -- Broadcast nvim-cmp capabilities to all servers
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        -- nvim 0.11 sets K, gd, gD, gi, gr, [d, ]d automatically on attach.
        -- Only set the non-defaults here.
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local map = vim.keymap.set
                local opts = { buffer = args.buf }
                map('n', 'go',   vim.lsp.buf.type_definition, opts)
                map('n', 'gs',   vim.lsp.buf.signature_help,  opts)
                map('n', '<F2>', function() return ':IncRename ' .. vim.fn.expand('<cword>') end, { expr = true, buffer = args.buf })
                map('n', '<F4>', vim.lsp.buf.code_action,      opts)
                map('n', 'gl',   vim.diagnostic.open_float,   opts)
            end,
        })
    end,
}
