local fn = vim.fn
local exec = vim.api.nvim_exec

local get_config = function(name)
    return string.format('require("config/%s")', name)
end

local plugins = {
    { -- lua snippets
        'L3MON4D3/LuaSnip',
        version = "v<CurrentMajor>.*",
        build = "make install_jsregexp",
        config = get_config('LuaSnip'),
    },

    { -- LSP boilerplate
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        },
        config = get_config('lsp-zero'),
    },

    { 'jayp0521/mason-null-ls.nvim' },  -- Mason/null-ls auto installer

    { -- helps with setting up LSP sources
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = get_config('null-ls'),
    },

    { -- file explorer
        'kyazdani42/nvim-tree.lua',
        config = get_config('nvim-tree'),
        dependencies = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        version = 'nightly' -- optional, updated every week. (see issue #1193)
    },

    { -- vim syntax theme (Nord)
        'EdenEast/nightfox.nvim',
        config = get_config('nightfox'),
    },

    { -- vim status line theme
        'nvim-lualine/lualine.nvim',
        config = get_config('lualine'),
        dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    },

    { -- devicons
        'kyazdani42/nvim-web-devicons',
        config = get_config('nvim-web-devicons'),
    },

    { -- highlight color codes
        'norcalli/nvim-colorizer.lua',
        config = get_config('nvim-colorizer'),
    },

    { -- comment motion
        'numToStr/Comment.nvim',
        config = get_config('Comment'),
    },

    { -- fuzzy finder
        'nvim-telescope/telescope.nvim', version = '0.1.0',
        config = get_config('telescope'),
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    { -- file sorter for telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    { -- language parser
        'nvim-treesitter/nvim-treesitter',
        config = get_config('nvim-treesitter'),
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },

    { -- autocomplete menu for vim commands
        'gelguy/wilder.nvim',
        config = get_config('wilder'),
        build = ':UpdateRemotePlugins',
    },

    { -- autopair surround characters
        'windwp/nvim-autopairs',
        config = get_config('nvim-autopairs'),
    },

    { -- buffer tabs
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        config = get_config('barbar'),
    },

    { -- notes
        'vimwiki/vimwiki',
        config = get_config('vimwiki'),
    },

    { 'airblade/vim-gitgutter' }, -- show git diff in side column
    { 'christoomey/vim-sort-motion' }, -- sort bindings
    { 'christoomey/vim-tmux-navigator' }, -- smart pane switcher
    { 'easymotion/vim-easymotion' }, -- find letter
    { 'mattn/calendar-vim' }, -- calendar for vimwiki
    { 'maxmellon/vim-jsx-pretty' }, -- React syntax highlighting
    { 'mg979/vim-visual-multi' }, -- multi cursor
    { 'sheerun/vim-polyglot' }, -- vim language packs
    { 'tpope/vim-fugitive' }, -- git
    { 'tpope/vim-obsession' }, -- session management
    { 'tpope/vim-surround' }, -- modify surround chars
    { 'yuezk/vim-js' }, -- syntax highlighting for JS
}

require("lazy").setup(plugins, opts)

exec([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile profile=true
  augroup end
]], false)
