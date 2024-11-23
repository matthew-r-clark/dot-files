local map = vim.keymap.set

local function buf_modified(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, 'modified')
end

local function buf_empty(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)
    return #lines == 1 and #lines[1] == 0
end

local function open_neo_tree()
    local current_buffer = vim.api.nvim_get_current_buf();

    if (not buf_modified(current_buffer) and buf_empty(current_buffer)) then
        vim.cmd(':Neotree float<CR>')
    end
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    init = function()
        map('n', '<leader>O', ':Neotree toggle reveal float<CR>', {})
    end,
    config = function()
        require('neo-tree').setup({
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
            },
        })

        -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_neo_tree })
    end,
}
