local function create_session_if_none()
    local function session_exists()
        local sessionFilePath = string.format("%s/Session.vim", vim.fn.getcwd())
        local f=io.open(sessionFilePath, 'r')

        if f~=nil then
            io.close(f)
            return true
        else
            return false
        end
    end

    if not session_exists() then
        vim.cmd(':Obsession')
    end
end

return {
    'tpope/vim-obsession', -- session management
    config = create_session_if_none,
}
