local fn = vim.fn
local exec = vim.api.nvim_exec
local packer = require('packer')

local get_config = function(name)
    return string.format('require("config/%s")', name)
end

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  exec([[packadd packer.nvim]], false)
end

packer.init({
    enable = true,
    threshold = 0,
    max_jobs = 20,
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    use { -- lua snippets
        'L3MON4D3/LuaSnip',
        tag = "v<CurrentMajor>.*",
        run = "make install_jsregexp",
        config = get_config('LuaSnip'),
    }

    use { -- LSP boilerplate
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
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
    }

    use({ 'jayp0521/mason-null-ls.nvim' })  -- Mason/null-ls auto installer

    use ({ -- helps with setting up LSP sources
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = get_config('null-ls'),
    })

    use { -- file explorer
        'kyazdani42/nvim-tree.lua',
        config = get_config('nvim-tree'),
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use { -- vim syntax theme (Nord)
        'EdenEast/nightfox.nvim',
        config = get_config('nightfox'),
    }

    use { -- vim status line theme
        'nvim-lualine/lualine.nvim',
        config = get_config('lualine'),
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use { -- devicons
        'kyazdani42/nvim-web-devicons',
        config = get_config('nvim-web-devicons'),
    }

    use { -- highlight color codes
        'norcalli/nvim-colorizer.lua',
        config = get_config('nvim-colorizer'),
    }

    use { -- comment motion
        'numToStr/Comment.nvim',
        config = get_config('Comment'),
    }

    use { -- fuzzy finder
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        config = get_config('telescope'),
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { -- file sorter for telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use { -- language parser
        'nvim-treesitter/nvim-treesitter',
        config = get_config('nvim-treesitter'),
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    use { -- autocomplete menu for vim commands
        'gelguy/wilder.nvim',
        config = get_config('wilder'),
        run = ':UpdateRemotePlugins',
    }

    use { -- autopair surround characters
        'windwp/nvim-autopairs',
        config = get_config('nvim-autopairs'),
    }

    use 'airblade/vim-gitgutter' -- show git diff in side column
    use 'christoomey/vim-sort-motion' -- sort bindings
    use 'christoomey/vim-tmux-navigator' -- smart pane switcher
    use 'easymotion/vim-easymotion' -- find letter
    use 'mattn/calendar-vim' -- calendar for vimwiki
    use 'maxmellon/vim-jsx-pretty' -- React syntax highlighting
    use 'mg979/vim-visual-multi' -- multi cursor
    use 'sheerun/vim-polyglot' -- vim language packs
    use 'tpope/vim-fugitive' -- git
    use 'tpope/vim-obsession' -- session management
    use 'tpope/vim-surround' -- modify surround chars
    use 'vimwiki/vimwiki' -- notes
    use 'w0rp/ale' -- prettier
    use 'yuezk/vim-js' -- syntax highlighting for JS
end)

exec([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile profile=true
  augroup end
]], false)
