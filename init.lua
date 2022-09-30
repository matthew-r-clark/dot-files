require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { -- file explorer
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use 'EdenEast/nightfox.nvim' -- vim syntax theme (Nord)

    use {
        'nvim-lualine/lualine.nvim', -- vim status line theme
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use 'norcalli/nvim-colorizer.lua' -- highlight color codes
    
    use 'christoomey/vim-sort-motion' -- sort bindings

    use 'easymotion/vim-easymotion' -- find letter

    use 'w0rp/ale' -- prettier

    use 'sheerun/vim-polyglot' -- vim language packs

    use 'yuezk/vim-js' -- syntax highlighting for JS
    
    use 'maxmellon/vim-jsx-pretty' -- React syntax highlighting

    use 'tpope/vim-fugitive' -- git

    use 'tpope/vim-surround' -- modify surround chars

    use 'airblade/vim-gitgutter' -- show git diff in side column

    use 'mg979/vim-visual-multi' -- multi cursor

    use { -- comment motion
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }

    use { -- fuzzy finder
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { -- file sorter for telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }    

    use { -- language parser
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
end)

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf')

telescope.setup({
    defaults = {
        vimgrep_arguments = { -- live_grep()
             'rg', '--follow', '--color=never', '--no-heading',
            '--with-filename', '--line-number', '--column', '--smart-case',
            '--hidden', '--no-ignore', '--glob', '!.git/*', '--glob',
            '!/node_modules',
        },
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<Tab>'] = actions.move_selection_next,
                ['<S-Tab>'] = actions.move_selection_previous,
            }
        },
        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        layout_strategy = 'flex',
        layout_config = {
            width = 0.75,
            prompt_position = 'bottom',
            preview_cutoff = 120,
            horizontal = {mirror = false},
            vertical = {mirror = true}
        },
        set_env = {['COLORTERM'] = 'truecolor'},
    },
    pickers = {
        find_files = {
            find_command = {
                'rg', '--hidden', '--files', '--no-ignore', '--glob',
                '!.git/*', '--glob', '!/node_modules',
            },
        },
    },
})

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require('nvim-tree').setup({
    open_on_setup = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    hijack_unnamed_buffer_when_opening = true,
    auto_reload_on_write = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        -- ignore_list = [],
    },
    renderer = {
        icons = {
            show = {
                git = true,
            },
        },
    },
    view = {
        adaptive_size = true,
    },
})
require('nvim-web-devicons').setup({ default = true })

require('nightfox').setup({
    options = {
        transparent = true,
        dim_inactive = true,
        styles = {
            keywords = 'bold',
        },
    },
    groups = {
        all = {
            CursorLine = { bg = '#3B4252' },
            CursorColumn = { bg = '#3B4252' },
        },
    },
})

require('lualine').setup({
    options = {
        theme = 'nord',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree' },
    },
    sections = {
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                color = {
                    fg = '#2E3440',
                    bg = vim.bo.modified and '#88C0D0' or '#4C566A',
                },
                path = 3,
                shorting_target = 10,
            },
        },
        lualine_x = {
            {
                'filetype',
                icon_only = true,
            },
        },
        lualine_y = {},
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 2,
                show_filename_only = false,
                buffers_color = {
                    active = { fg = '#2E3440', bg = '#88C0D0' },
                    inactive = { fg = '#2E3440', bg = '#4C566A' },
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})

vim.opt.termguicolors = true
require('colorizer').setup({'*'})

local map = vim.api.nvim_set_keymap
vim.g.mapleader = ' '
map('n', '<leader>1', '<cmd>LualineBuffersJump 1<cr>', {})
map('n', '<leader>2', '<cmd>LualineBuffersJump 2<cr>', {})
map('n', '<leader>3', '<cmd>LualineBuffersJump 3<cr>', {})
map('n', '<leader>4', '<cmd>LualineBuffersJump 4<cr>', {})
map('n', '<leader>5', '<cmd>LualineBuffersJump 5<cr>', {})
map('n', '<leader>6', '<cmd>LualineBuffersJump 6<cr>', {})
map('n', '<leader>7', '<cmd>LualineBuffersJump 7<cr>', {})
map('n', '<leader>8', '<cmd>LualineBuffersJump 8<cr>', {})
map('n', '<leader>9', '<cmd>LualineBuffersJump 9<cr>', {})
map('n', '<leader>0', '<cmd>LualineBuffersJump 10<cr>', {})
map('n', '<leader><leader>1', '<cmd>LualineBuffersJump 11<cr>', {})
map('n', '<leader><leader>2', '<cmd>LualineBuffersJump 12<cr>', {})
map('n', '<leader><leader>3', '<cmd>LualineBuffersJump 13<cr>', {})
map('n', '<leader><leader>4', '<cmd>LualineBuffersJump 14<cr>', {})
map('n', '<leader><leader>5', '<cmd>LualineBuffersJump 15<cr>', {})
map('n', '<leader><leader>6', '<cmd>LualineBuffersJump 16<cr>', {})
map('n', '<leader><leader>7', '<cmd>LualineBuffersJump 17<cr>', {})
map('n', '<leader><leader>8', '<cmd>LualineBuffersJump 18<cr>', {})
map('n', '<leader><leader>9', '<cmd>LualineBuffersJump 19<cr>', {})
map('n', '<leader><leader>0', '<cmd>LualineBuffersJump 20<cr>', {})

vim.cmd('source ~/.vim/.vimrc')
vim.o.showtabline = 2
