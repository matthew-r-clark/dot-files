local function session_exists()
    local sessionFilePath = string.format("%s/Session.vim", vim.fn.getcwd())
    local f = io.open(sessionFilePath, 'r')
    if f ~= nil then
        io.close(f)
        return true
    end
    return false
end

return {
    'tpope/vim-obsession', -- session management
    config = function()
        vim.api.nvim_create_autocmd('VimEnter', {
            nested = true,
            callback = function()
                if session_exists() then
                    -- restore session if nvim was opened with no file arguments
                    if vim.fn.argc() == 0 then
                        vim.cmd('silent! source Session.vim')
                    end
                else
                    vim.cmd(':Obsession')
                end
            end,
        })
    end,
}
