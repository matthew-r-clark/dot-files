local map = vim.api.nvim_set_keymap

map('', '<leader>gd', ':Gvdiff<CR>', {}) -- side-by-side diff
map('', '<leader>gb', ':Git blame<CR>', {})
map('', '<leader>gs', ':Git<CR>', {}) -- git status
