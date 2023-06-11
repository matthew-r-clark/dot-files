local map = vim.api.nvim_set_keymap

map('n', '<leader>j', ':BufferMovePrevious<cr>', {})
map('n', '<leader>k', ':BufferMoveNext<cr>', {})
map('n', '<leader>[', ':BufferPrevious<cr>', {})
map('n', '<leader>]', ':BufferNext<cr>', {})

map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', {})
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', {})
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', {})
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', {})
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', {})
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', {})
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', {})
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', {})
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', {})

map('n', '<C-p>', ':BufferPick<cr>', {})
map('n', '<C-c>', ':BufferClose<cr>', {})

vim.opt.sessionoptions:append 'globals'
vim.api.nvim_create_user_command(
  'Mksession',
  function(attr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})
    vim.cmd.mksession {bang = attr.bang, args = attr.fargs}
  end,
  {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
)
