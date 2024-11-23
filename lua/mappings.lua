local map = vim.keymap.set

-- delete all buffers
map('n', '<leader>bad', ':%bd<CR>', {})

-- resourece nvim config
map('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', {})

-- motions for angle brackets
map('n', 'vat', 'va<', {})
map('n', 'vit', 'vi<', {})
map('n', 'dat', 'da<', {})
map('n', 'dit', 'di<', {})
map('n', 'cat', 'ca<', {})
map('n', 'cit', 'ci<', {})

-- yank, select, and delete all
map('n', '<leader>ya', 'gg0vGg_y', {})
map('n', '<leader>va', 'ggVGg_', {})
map('n', '<leader>da', 'ggVGd', {})

-- toggle relative line numbering
map('n', '<leader>n', ':set invrelativenumber<CR>', {})

-- vim resizing
map('', '<M-l>', ':vertical resize +3<CR>', {})
map('', '<M-h>', ':vertical resize -3<CR>', {})
map('', '<M-j>', ':resize -1<CR>', {})
map('', '<M-k>', ':resize +1<CR>', {})

-- vim pane split management
map('', '<leader>sv', '<C-w>v', {})
map('', '<leader>sh', '<C-w>s', {})
map('', '<leader>se', '<C-w>=', {})
