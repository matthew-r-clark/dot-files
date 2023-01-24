global = vim.g
opt = vim.opt
hi = vim.api.nvim_set_hl
exec = vim.api.nvim_exec
fn = vim.fn

exec([[colorscheme nordfox]], false)

global.loaded = 1
global.loaded_netrwPlugin = 1
global.mapleader = ' '
global.session_autosave = 'no'
global.tmux_navigator_preserve_zoom = 1

-- ALE {{{
global.ale_fixers = {-- ale eslint autofix
    javascript = {
        'eslint',
    },
}
global.ale_fix_on_save = 1
global.ale_sign_error = ''
global.ale_sign_warning = ''
-- ALE }}}

global.sort_motion_flags = 'ui'
global.EasyMotion_smartcase = 1 -- easymotion ignore case on search

-- Options {{{
opt.autoindent = true
opt.autoread = true
opt.ch = 1
opt.clipboard = 'unnamed'
opt.colorcolumn = '80'
opt.compatible = false
opt.cursorline = true
opt.dict = 'usr/share/dict/words'
opt.diffopt = 'internal,filler,closeoff,iwhiteall'
opt.encoding = 'UTF-8'
opt.expandtab = true
opt.fixeol = false
opt.foldenable = true
opt.foldmethod = 'marker'
-- opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
opt.ignorecase = true
opt.lazyredraw = true
opt.list = true
opt.listchars = {tab = '›⋅', eol = '↲', space = '⋅'}
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.scl = 'yes'
opt.shiftwidth = 4
opt.showmatch = true
opt.softtabstop = 0
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.visualbell = true
opt.wrap = false
-- }}}

-- Packer {{{
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
end)
-- }}}

-- Plugin Config {{{
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
                preview_width = 0.5,
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
        mappings = {
            list = {
                { key = "h", action = "split" },
                { key = "v", action = "vsplit" },
            },
        },
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
                mode = 2, -- always show tabline
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
-- }}}

local map = vim.api.nvim_set_keymap
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

-- packer shortcuts {{{
map('n', '<leader><leader>pc', ':PackerCompile<CR>', {})
map('n', '<leader><leader>pi', ':PackerInstall<CR>', {})
map('n', '<leader><leader>pu', ':PackerUpdate<CR>', {})
map('n', '<leader><leader>pC', ':PackerClean<CR>', {})
-- }}}

-- vim-fugitive {{{
map('', '<leader>gd', ':Gvdiff<CR>', {}) -- side-by-side diff
map('', '<leader>gb', ':Git blame<CR>', {})
map('', '<leader>gs', ':Git<CR>', {}) -- git status
-- }}}

-- vim resizing {{{
map('', '<M-l>', ':vertical resize +5<CR>', {})
map('', '<M-h>', ':vertical resize -5<CR>', {})
map('', '<M-j>', ':resize -5<CR>', {})
map('', '<M-k>', ':resize +5<CR>', {})
-- }}}

map('', '<leader>l', ':ALEToggle<CR>', {})
map('', '<leader>f', '<Plug>(easymotion-bd-f)', {})
map('', '<leader>o', ':NvimTreeToggle<CR>', {})
map('', '<leader>p', ':Telescope find_files<cr>', {})
map('', '<leader>gf', ':GF?<CR>', {})
map('', '<leader>/', ':Telescope live_grep<cr> ', {})
map('', '<leader>w', ':w<CR>', {})
map('', '<leader>bd', ':bd<CR>', {})
map('', '<leader>bwd', ':w<CR>:bd<CR>', {})
map('', '<leader>X', ':x<CR>', {})
map('', '<leader>bD', ':bd!<CR>', {})
map('', '<leader>bad', ':%bd<CR>', {})
map('', '<leader>q', ':q<CR>', {})
map('', '<leader>Q', ':q!<CR>', {})
map('', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', {})
map('', 'p', 'p`[v`]y', {})
map('', 'P', 'P`[v`]y', {})
map('', 'vat', 'va<', {})
map('', 'vit', 'vi<', {})
map('', 'dat', 'da<', {})
map('', 'dit', 'di<', {})
map('', 'cat', 'ca<', {})
map('', 'cit', 'ci<', {})
map('', '<leader>ya', 'gg0vGg_y', {})
map('', '<leader>va', 'ggVGg_', {})
map('', '<leader>da', 'ggVGd', {})
map('', '<leader>n', ':set invrelativenumber<CR>', {})

-- vim pane split management {{{
map('', '<leader>ev', ':vsplit ', {})
map('', '<leader>eh', ':split ', {})
map('', '<leader>sv', '<C-w>v', {})
map('', '<leader>sh', '<C-w>s', {})
map('', '<leader>s=', '<C-w>=', {})
map('', '<leader>kp', '<C-w>q', {})
-- }}}

hi(0, 'ALEErrorSign', { bg = '#2E3440', fg = '#BF616A' })
hi(0, 'ALEWarningSign', { bg = '#2E3440', fg = '#EBCB8B' })
