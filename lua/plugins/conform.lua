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
        format_on_save = function(bufnr)
            local eslint_fts = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }
            if eslint_fts[vim.bo[bufnr].filetype] then
                return { lsp_fallback = true }
            end
        end,
        formatters_by_ft = {
            javascript      = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescript      = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            json            = { 'prettierd' },
            jsonc           = { 'prettierd' },
            html            = { 'prettierd' },
            css             = { 'prettierd' },
            yaml            = { 'prettierd' },
            markdown        = { 'prettierd' },
        },
    },
}
