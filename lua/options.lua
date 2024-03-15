local global = vim.g
local opt = vim.opt
local hi = vim.api.nvim_set_hl

global.loaded = 1
global.loaded_netrwPlugin = 1
global.session_autosave = 'no'
global.tmux_navigator_preserve_zoom = 1

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
opt.formatoptions = 'crqnj' -- https://neovim.io/doc/user/change.html#fo-table
opt.ignorecase = true
opt.list = true
opt.listchars = {tab = '›⋅', eol = '↲', space = '⋅'}
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.scl = 'yes'
opt.shiftwidth = 4
opt.showmatch = true
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 0
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.textwidth = 80
opt.undofile = true
opt.visualbell = true
opt.wrap = false

hi(0, 'Normal', {bg='NONE'})
hi(0, 'NormalNC', {bg='#181E2A'}) -- should match terminal background color
