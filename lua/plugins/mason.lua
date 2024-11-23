local language_servers = require('constants').language_servers

local tsserver_config = function ()
    require('lspconfig').ts_ls.setup({ -- to disable type checking in js
        on_init = function (client)       -- files, add a .jsconfig.json
            local utils = require('nvim-lsp-ts-utils')
            utils.setup({
                filter_out_diagnostics_by_code = {
                    7016, -- Type definitions missing from JS package
                    80001, -- CommonJS module may be converted to ESM
                },
                filter_out_diagnostics_by_severity = { 'hint' },
            })
            utils.setup_client(client)
        end
    })
end

local bashls_config = function ()
    require('lspconfig').bashls.setup({
        filetypes = {
            'sh',
            'bash',
            'zsh',
        },
    })
end

local lua_ls_config = function ()
    require('lspconfig').lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        'vim',
                    }
                }
            }
        }
    })
end

local eslint_config = function ()
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
end

return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        ensure_installed = language_servers,
        automatic_installation = true,
        handlers = {
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            tsserver = tsserver_config,
            bashls = bashls_config,
            lua_ls = lua_ls_config,
            eslint = eslint_config,
        },
    },
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
        { -- LSP typescript utilities
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
        },
    },
}
