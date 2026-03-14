return {
    {
        'willothy/flatten.nvim',
        opts = {
            window = {
                type = "current",
            },
            hooks = {
                post_open = function(bufnr, winnr, ft, is_blocking)
                    -- stop the lazygit job; TermClose autocmd handles the rest
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.bo[buf].buftype == "terminal" then
                            local name = vim.api.nvim_buf_get_name(buf)
                            if name:match("lazygit") then
                                local job_id = vim.b[buf].terminal_job_id
                                if job_id then
                                    vim.fn.jobstop(job_id)
                                end
                                break
                            end
                        end
                    end
                end,
            },
        },
    },
}
