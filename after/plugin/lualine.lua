local map = vim.api.nvim_set_keymap

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

local function update_tabline_max_length()
    require('lualine').setup({
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
        },
    })
end

vim.api.nvim_create_autocmd({ "VimResized" }, { callback = update_tabline_max_length })
