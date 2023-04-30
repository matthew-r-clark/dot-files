-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = true,
})

require('mason').setup({
    ensure_installed = {
        'tsserver',
    }
})

local cmp = require('cmp')
local ls = require('luasnip')

cmp.setup({
    completion = {
        autocomplete = true,
    },
    snippet = {
        expand = function (args)
            ls.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { use_show_condition = false } },
    },
 })
