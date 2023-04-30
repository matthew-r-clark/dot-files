local fn = vim.fn
local exec = vim.api.nvim_exec
local packer = require('packer')

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

    use {
        'L3MON4D3/LuaSnip',
        tag = "v<CurrentMajor>.*",
        run = "make install_jsregexp",
        config = function ()
            local ls = require('luasnip')
            ls.filetype_extend('javascript', { 'javascriptreact' })
            ls.filetype_extend('javascript', { 'html' })
            require('luasnip.loaders.from_vscode').lazy_load()
            require('snippets/index')
        end,
    }

    use {
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
        config = function()
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
        end
    }

    use({ 'jayp0521/mason-null-ls.nvim' })                                              -- Mason/null-ls auto installer

    use ({
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            local null_ls = require('null-ls')

            null_ls.setup({
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
        end,
    })     

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

    use 'christoomey/vim-tmux-navigator' -- smart pane switcher

    use { -- comment motion
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$',
            })
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

    use {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')

            wilder.setup({
                modes = {':'},
            })

            wilder.set_option('renderer', wilder.popupmenu_renderer(
                wilder.popupmenu_border_theme({
                    border = 'rounded',
                    highlights = {
                        border = 'Normal',
                    },
                    left = {' ', wilder.popupmenu_devicons()},
                    right = {' ', wilder.popupmenu_scrollbar()},
                })
            ))

            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        language = 'python',
                        fuzzy = 2,
                    })
                ),
            })
        end,
        run = ':UpdateRemotePlugins',
    }

    use {
        'vimwiki/vimwiki',
    }

    use {
        'mattn/calendar-vim',
    }

    use {
        'tpope/vim-obsession',
    }
end)

exec([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile profile=true
  augroup end
]], false)


-- CONFIG

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf')

telescope.setup({
    defaults = {
        vimgrep_arguments = { -- live_grep()
             'rg', '--follow', '--color=never', '--no-heading',
            '--with-filename', '--line-number', '--column', '--smart-case',
            '--hidden', '--no-ignore',
            '--glob', '!.git/*',
            '--glob', '!/node_modules',
            '--glob', '!.next',
            '--glob', '!package-lock.json',
            '--glob', '!projects/**/node_modules',
            '--glob', '!build-node-docker/node_modules',
            '--glob', '!build/*',
            '--glob', '!dist/*',
            '--glob', '!Session.vim',
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
            width = 0.99,
            prompt_position = 'bottom',
            preview_cutoff = 0,
            horizontal = {
                preview_width = 0.55,
                mirror = false
            },
            vertical = {
                mirror = false,
            }
        },
        set_env = {['COLORTERM'] = 'truecolor'},
    },
    pickers = {
        find_files = {
            find_command = {
                'rg', '--hidden', '--files', '--no-ignore',
                '--glob', '!.git/*',
                '--glob', '!/node_modules',
                '--glob', '!.next',
                '--glob', '!projects/**/node_modules',
                '--glob', '!build-node-docker/node_modules',
                '--glob', '!build/*',
                '--glob', '!dist/*',
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
    git = {
        ignore = false,
    },
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
        mappings = {
            list = {
                { key = "h", action = "split" },
                { key = "v", action = "vsplit" },
            },
        },
    },
})
local function open_nvim_tree()
    require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
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
            NormalNC = { bg = '#181E2A' },
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
                mode = 2, -- shows buffer name + buffer index
                show_filename_only = false,
                buffers_color = {
                    active = { fg = '#2E3440', bg = '#88C0D0' },
                    inactive = { fg = '#2E3440', bg = '#4C566A' },
                },
                max_length = vim.o.columns,
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})

require('colorizer').setup({'*'})

vim.defer_fn(require('vim-obsession.initialize'), 1000)
