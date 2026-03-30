return { -- formatting
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    keys = {
        {
            '<C-f>',
            function()
                require('conform').format({ lsp_fallback = true })
            end,
            mode = { 'n', 'v' },
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            javascript      = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            typescript      = { 'prettierd' },
            typescriptreact = { 'prettierd' },
            json            = { 'prettierd' },
            jsonc           = { 'prettierd' },
            html            = { 'prettierd' },
            css             = { 'prettierd' },
            yaml            = { 'prettierd' },
            markdown        = { 'prettierd' },
        },
    },
}
