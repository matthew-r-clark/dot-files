local map = vim.keymap.set

return { -- find letter
    'easymotion/vim-easymotion',
    init = function()
        map('n', '<leader>f', '<Plug>(easymotion-bd-f)', {})
    end,
}
