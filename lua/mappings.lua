local map = vim.api.nvim_set_keymap

-- general
map('', '<C-f>', ':LspZeroFormat<CR>', {})
map('n', '<leader>f', '<Plug>(easymotion-bd-f)', {})
map('n', '<leader>o', ':Neotree toggle reveal float<CR>', {})
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

-- vim resizing
map('', '<M-l>', ':vertical resize +3<CR>', {})
map('', '<M-h>', ':vertical resize -3<CR>', {})
map('', '<M-j>', ':resize -1<CR>', {})
map('', '<M-k>', ':resize +1<CR>', {})

-- vim pane split management
map('', '<leader>sv', '<C-w>v', {})
map('', '<leader>sh', '<C-w>s', {})
map('', '<leader>s=', '<C-w>=', {})
map('', '<leader>kp', '<C-w>q', {})
