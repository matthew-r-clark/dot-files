local function session_exists()
    local sessionFilePath = string.format("%s/Session.vim", vim.fn.getcwd())
    local f=io.open(sessionFilePath, 'r')
    if f~=nil then io.close(f) return true else return false end
end

local function initialize()
    if session_exists() then
        vim.cmd(':source Session.vim')
    else
        vim.cmd(':Obsession')
    end
end

return initialize