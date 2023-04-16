local cwd = vim.fn.getcwd()
local sessionFilePath = cwd..'/Session.vim'

local function session_exists()
    local f=io.open(sessionFilePath, 'r')
    if f~=nil then io.close(f) return true else return false end
end

local function initialize()
    if session_exists() then
        vim.cmd('source Session.vim')
    else
        vim.cmd(':Obsession')
    end
end

return initialize
