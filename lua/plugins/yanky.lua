local map = vim.keymap.set

return {
    'gbprod/yanky.nvim',
    init = function()
        map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', {})
        map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', {})
        map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', {})
        map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', {})
        map('n', '<c-]>', '<Plug>(YankyCycleForward)', {})
        map('n', '<c-[>', '<Plug>(YankyCycleBackward)', {})
    end,
    opts = {
        ring = {
            history_length = 100,
            storage = "shada",
            sync_with_numbered_registers = true,
            cancel_event = "update",
        },
        picker = {
            select = {
                action = nil, -- nil to use default put action
            },
            telescope = {
                use_default_mappings = true, -- if default mappings should be used
                mappings = nil,              -- nil to use default mappings or no mappings (see `use_default_mappings`)
            },
        },
        system_clipboard = {
            sync_with_ring = true,
        },
        highlight = {
            on_put = false,
            on_yank = false,
            timer = 500,
        },
        preserve_cursor_position = {
            enabled = true,
        },
    }
}
