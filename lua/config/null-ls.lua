local null_ls = require('null-ls')

null_ls.init({
    sources = {
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.proselint,
        null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.code_actions.cspell,
        -- null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.hover.printenv,
        null_ls.builtins.completion.luasnip,
    }
})
