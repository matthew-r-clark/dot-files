local map = vim.keymap.set

-- lazygit in current window
map('n', '<leader>lg', function()
    -- reuse existing lazygit terminal if already open
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_get_name(buf):match("lazygit") then
            vim.api.nvim_set_current_buf(buf)
            vim.cmd('startinsert')
            return
        end
    end
    local prev_buf = vim.api.nvim_get_current_buf()
    vim.cmd('terminal lazygit')
    vim.cmd('startinsert')
    local term_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd('TermClose', {
        buffer = term_buf,
        once = true,
        callback = function()
            vim.schedule(function()
                pcall(vim.api.nvim_buf_delete, term_buf, { force = true })
                -- only return to prev_buf if flatten didn't already open a file
                local cur = vim.api.nvim_get_current_buf()
                if vim.bo[cur].buftype ~= "" or cur == term_buf then
                    if vim.api.nvim_buf_is_valid(prev_buf) then
                        vim.api.nvim_set_current_buf(prev_buf)
                    end
                end
            end)
        end,
    })
end, {})

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
