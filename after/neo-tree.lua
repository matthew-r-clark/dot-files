local function buf_modified(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, 'modified')
end

local function buf_empty(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)
    return #lines == 1 and #lines[1] == 0
end

local function open_nvim_tree()
    local current_buffer = vim.api.nvim_get_current_buf();

    if (not buf_modified(current_buffer) and buf_empty(current_buffer)) then
        vim.cmd(':Neotree')
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
