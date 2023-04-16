local global = vim.g
local opt = vim.opt
local hi = vim.api.nvim_set_hl
local exec = vim.api.nvim_exec

exec([[colorscheme nordfox]], false)

require('plugins')

-- Options {{{
global.loaded = 1
global.loaded_netrwPlugin = 1
global.mapleader = ' '
global.session_autosave = 'no'
global.tmux_navigator_preserve_zoom = 1
local map = vim.api.nvim_set_keymap

-- ALE
global.ale_fixers = {-- ale eslint autofix
    javascript = {
        'eslint',
    },
}
global.ale_fix_on_save = 0
global.ale_sign_error = ''
global.ale_sign_warning = ''
hi(0, 'ALEErrorSign', { bg = '#2E3440', fg = '#BF616A' })
hi(0, 'ALEWarningSign', { bg = '#2E3440', fg = '#EBCB8B' })

-- vim-wiki
global.vimwiki_map_prefix = '<leader>vw'
global.vimwiki_list = {{
    path = '~/vimwiki/',
    -- rx_todo = vim.regex('TODO|DONE|STARTED|FIXME|FIXED|XXX'),
}}
global.vimwiki_listsyms = ' 123456789✓'
-- global.vimwiki_folding = 'list'
map('n', '<leader>vw', '<cmd>VimwikiIndex<cr>', {})
map('n', '<leader>dw', '<cmd>VimwikiDiaryIndex<cr>', {})
map('n', '<leader>dn', '<cmd>VimwikiMakeDiaryNote<cr>', {})
map('n', '<leader>dy', '<cmd>VimwikiMakeYesterdayDiaryNote<cr>', {})
map('n', '<leader>dt', '<cmd>VimwikiMakeTomorrowDiaryNote<cr>', {})
map('n', '<leader>dr', '<cmd>VimwikiDiaryGenerateLinks<cr><leader>w', {})

-- easymotion
global.sort_motion_flags = 'ui'
global.EasyMotion_smartcase = 1 -- easymotion ignore case on search

-- general
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
opt.formatoptions = 'crqnj'
-- {{{ formatoptions descriptions
--[[
    c -> auto-wrap comments
    r -> auto-insert comment leader after hitting <Enter> in insert mode
    q -> allow formatting of comments with "gq"
    n -> recognized numbered lists
    j -> auto-remove comments when joining lines
]]
-- }}}
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
opt.textwidth = 80
opt.visualbell = true
opt.wrap = false
-- }}}

-- lualine buffer jump mappings {{{
map('n', '<leader>1', '<cmd>LualineBuffersJump! 1<cr>', {})
map('n', '<leader>2', '<cmd>LualineBuffersJump! 2<cr>', {})
map('n', '<leader>3', '<cmd>LualineBuffersJump! 3<cr>', {})
map('n', '<leader>4', '<cmd>LualineBuffersJump! 4<cr>', {})
map('n', '<leader>5', '<cmd>LualineBuffersJump! 5<cr>', {})
map('n', '<leader>6', '<cmd>LualineBuffersJump! 6<cr>', {})
map('n', '<leader>7', '<cmd>LualineBuffersJump! 7<cr>', {})
map('n', '<leader>8', '<cmd>LualineBuffersJump! 8<cr>', {})
map('n', '<leader>9', '<cmd>LualineBuffersJump! 9<cr>', {})
map('n', '<leader>0', '<cmd>LualineBuffersJump! 10<cr>', {})
map('n', '<leader><leader>1', '<cmd>LualineBuffersJump! 11<cr>', {})
map('n', '<leader><leader>2', '<cmd>LualineBuffersJump! 12<cr>', {})
map('n', '<leader><leader>3', '<cmd>LualineBuffersJump! 13<cr>', {})
map('n', '<leader><leader>4', '<cmd>LualineBuffersJump! 14<cr>', {})
map('n', '<leader><leader>5', '<cmd>LualineBuffersJump! 15<cr>', {})
map('n', '<leader><leader>6', '<cmd>LualineBuffersJump! 16<cr>', {})
map('n', '<leader><leader>7', '<cmd>LualineBuffersJump! 17<cr>', {})
map('n', '<leader><leader>8', '<cmd>LualineBuffersJump! 18<cr>', {})
map('n', '<leader><leader>9', '<cmd>LualineBuffersJump! 19<cr>', {})
map('n', '<leader><leader>0', '<cmd>LualineBuffersJump! 20<cr>', {})
-- }}}

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
map('', '<M-l>', ':vertical resize +3<CR>', {})
map('', '<M-h>', ':vertical resize -3<CR>', {})
map('', '<M-j>', ':resize -1<CR>', {})
map('', '<M-k>', ':resize +1<CR>', {})
-- }}}

-- general key mappings {{{
map('', '<C-f>', ':LspZeroFormat<CR>', {})
map('n', '<leader>l', ':ALEToggle<CR>', {})
map('n', '<leader>f', '<Plug>(easymotion-bd-f)', {})
map('n', '<leader>o', ':NvimTreeToggle<CR>', {})
map('n', '<leader>p', ':Telescope find_files<cr>', {})
map('n', '<leader>gf', ':GF?<CR>', {})
map('n', '<leader>/', ':Telescope live_grep<cr>', {})
map('n', '<leader>w', ':w<CR>', {})
map('n', '<leader>aw', ':wa<CR>', {})
map('n', '<leader>bd', ':bd<CR>', {})
map('n', '<leader>bwd', ':w<CR>:bd<CR>', {})
map('n', '<leader>X', ':x<CR>', {})
map('n', '<leader>bD', ':bd!<CR>', {})
map('n', '<leader>bad', ':%bd<CR>', {})
map('n', '<leader>q', ':q<CR>', {})
map('n', '<leader>Q', ':q!<CR>', {})
map('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', {})
map('n', 'vat', 'va<', {})
map('n', 'vit', 'vi<', {})
map('n', 'dat', 'da<', {})
map('n', 'dit', 'di<', {})
map('n', 'cat', 'ca<', {})
map('n', 'cit', 'ci<', {})
map('n', '<leader>ya', 'gg0vGg_y', {})
map('n', '<leader>va', 'ggVGg_', {})
map('n', '<leader>da', 'ggVGd', {})
map('n', '<leader>n', ':set invrelativenumber<CR>', {})
-- }}}

-- vim pane split management {{{
map('', '<leader>sv', '<C-w>v', {})
map('', '<leader>sh', '<C-w>s', {})
map('', '<leader>s=', '<C-w>=', {})
map('', '<leader>kp', '<C-w>q', {})
-- }}}
