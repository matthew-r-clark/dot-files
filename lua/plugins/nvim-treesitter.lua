return { -- language parser
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- main branch does not support lazy-loading
    build = ':TSUpdate',
    -- main dropped opts/setup() config (ensure_installed, highlight.enable, auto_install, etc.);
    -- parser install and highlighting are now done explicitly.
    config = function()
        local parsers = { 'lua', 'javascript', 'markdown', 'markdown_inline' }

        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'lua', 'javascript', 'markdown' },
            callback = function() vim.treesitter.start() end,
        })
    end,
}
