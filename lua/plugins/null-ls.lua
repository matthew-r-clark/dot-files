return { -- helps with setting up LSP sources
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.code_actions.proselint,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.code_actions.cspell,
                -- null_ls.builtins.diagnostics.cspell,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.hover.printenv,
            }
        })
    end,
}
