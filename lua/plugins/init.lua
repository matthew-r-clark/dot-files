return {
    -- { -- lua snippets
    --     'L3MON4D3/LuaSnip',
    --     version = "v<CurrentMajor>.*",
    --     build = "make install_jsregexp",
    --     -- config = get_config('LuaSnip'),
    -- },

    -- { -- LSP boilerplate
    --     'VonHeikemen/lsp-zero.nvim',
    --     branch = 'v1.x',
    --     dependencies = {
    --         -- LSP Support
    --         'neovim/nvim-lspconfig',             -- Required
    --         'williamboman/mason.nvim',           -- Optional
    --         'williamboman/mason-lspconfig.nvim', -- Optional

    --         -- Autocompletion
    --         'hrsh7th/nvim-cmp',         -- Required
    --         'hrsh7th/cmp-nvim-lsp',     -- Required
    --         'hrsh7th/cmp-buffer',       -- Optional
    --         'hrsh7th/cmp-path',         -- Optional
    --         'saadparwaiz1/cmp_luasnip', -- Optional
    --         'hrsh7th/cmp-nvim-lua',     -- Optional

    --         -- Snippets
    --         'L3MON4D3/LuaSnip',             -- Required
    --         'rafamadriz/friendly-snippets', -- Optional
    --     },
    --     -- config = get_config('lsp-zero'),
    -- },

    -- { 'jayp0521/mason-null-ls.nvim' },  -- Mason/null-ls auto installer

    -- { -- helps with setting up LSP sources
    --     'jose-elias-alvarez/null-ls.nvim',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --     },
    --     -- config = get_config('null-ls'),
    -- },


    -- { -- devicons
    --     'kyazdani42/nvim-web-devicons',
    --     -- config = get_config('nvim-web-devicons'),
    -- },

    -- { -- autocomplete menu for vim commands
    --     'gelguy/wilder.nvim',
    --     -- config = get_config('wilder'),
    --     build = ':UpdateRemotePlugins',
    -- },

    { 'airblade/vim-gitgutter' }, -- show git diff in side column
    { 'christoomey/vim-sort-motion' }, -- sort bindings
    { 'christoomey/vim-tmux-navigator' }, -- smart pane switcher
    { 'easymotion/vim-easymotion' }, -- find letter
    { 'mattn/calendar-vim' }, -- calendar for vimwiki
    { 'maxmellon/vim-jsx-pretty' }, -- React syntax highlighting
    { 'mg979/vim-visual-multi' }, -- multi cursor
    { 'sheerun/vim-polyglot' }, -- vim language packs
    { 'tpope/vim-surround' }, -- modify surround chars
    { 'yuezk/vim-js' }, -- syntax highlighting for JS
}