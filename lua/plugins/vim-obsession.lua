local function session_exists()
    local sessionFilePath = string.format("%s/Session.vim", vim.fn.getcwd())
    local f = io.open(sessionFilePath, 'r')
    if f ~= nil then
        io.close(f)
        return true
    end
    return false
end

local function setup()
    if session_exists() then
        -- restore session if nvim was opened with no file arguments
        if vim.fn.argc() == 0 then
            vim.cmd('source Session.vim')
        end
    else
        vim.cmd(':Obsession')
    end
end

return {
    'tpope/vim-obsession', -- session management
    config = setup,
}
