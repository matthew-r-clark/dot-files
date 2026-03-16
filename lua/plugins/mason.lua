local language_servers = require('constants').language_servers

return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('mason-lspconfig').setup({
            ensure_installed = language_servers,
            automatic_installation = true,
        })

        require('lspconfig').ts_ls.setup({
            handlers = {
                ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
                    local filtered = {}
                    for _, diagnostic in ipairs(result.diagnostics or {}) do
                        local ignored_codes = { [7016] = true, [80001] = true }
                        local is_hint = diagnostic.severity == vim.diagnostic.severity.HINT
                        if not ignored_codes[diagnostic.code] and not is_hint then
                            table.insert(filtered, diagnostic)
                        end
                    end
                    result.diagnostics = filtered
                    vim.lsp.handlers['textDocument/publishDiagnostics'](_, result, ctx, config)
                end,
            },
        })

        require('lspconfig').bashls.setup({
            filetypes = { 'sh', 'bash', 'zsh' },
        })

        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        require('lspconfig').html.setup({})
        require('lspconfig').jsonls.setup({})
        require('lspconfig').yamlls.setup({})

        require('lspconfig').eslint.setup({
            settings = {
                codeActions = {
                    disableRuleComment = {
                        enable = true,
                        location = 'sameLine',
                    },
                },
            },
        })
    end,
    dependencies = {
        {
            "williamboman/mason.nvim",
            event = { "BufReadPre", "BufNewFile" },
            build = ":MasonUpdate",
            keys = {
                { "<leader>lI", "<cmd>Mason<CR>", desc = "Opens Mason" },
            },
            cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
            opts = {},
        },
    },
}
