local global = vim.g
local opt = vim.opt
local hi = vim.api.nvim_set_hl
local exec = vim.api.nvim_exec
local map = vim.api.nvim_set_keymap

exec([[colorscheme nordfox]], false)

global.loaded = 1
global.loaded_netrwPlugin = 1
global.mapleader = ' '
global.session_autosave = 'no'
global.tmux_navigator_preserve_zoom = 1

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
