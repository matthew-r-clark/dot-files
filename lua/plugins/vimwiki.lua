local global = vim.g
local map = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

return { -- notes
    'vimwiki/vimwiki',
    config = function()
        local AUTO_BACKUP_DELAY = 15 * 60 -- 15 minutes
        local BACKUP_FILEPATH = vim.fn.expand('$HOME/dot-files/.vimwiki_last_backup_time')

        local function auto_backup()
          local current_filename = vim.fn.expand('%')
          if string.find(current_filename, 'vimwiki/') then
            os.execute('touch ' .. BACKUP_FILEPATH)
            local file_read_handle = assert(io.open(BACKUP_FILEPATH,'r'))
            local last_updated = tonumber(file_read_handle:read('*a'))
            file_read_handle:close()

            if not last_updated or os.time() - last_updated > AUTO_BACKUP_DELAY then
              os.execute('~/dot-files/scripts/vimwiki-backup.sh')
              local file_write_handle = assert(io.open(BACKUP_FILEPATH, 'w'))
              file_write_handle:write(os.time())
              file_write_handle:close()
            end
          end
        end

        autocmd({ 'BufWritePost' }, { callback = auto_backup })

        global.vimwiki_map_prefix = '<leader>vw'
        global.vimwiki_list = {{
            path = '~/vimwiki/',
            -- rx_todo = vim.regex('TODO|DONE|STARTED|FIXME|FIXED|XXX'),
        }}
        global.vimwiki_listsyms = ' 123456789✓'
        -- global.vimwiki_folding = 'list'

        map('n', '<leader>vw', '<cmd>VimwikiIndex<cr>', {})
        map('n', '<leader>dw', '<cmd>VimwikiDiaryIndex<cr>', {})
        map('n', '<leader>dn', '<cmd>VimwikiMakeDiaryNote<cr>', {})
        map('n', '<leader>dy', '<cmd>VimwikiMakeYesterdayDiaryNote<cr>', {})
        map('n', '<leader>dt', '<cmd>VimwikiMakeTomorrowDiaryNote<cr>', {})
        map('n', '<leader>dr', '<cmd>VimwikiDiaryGenerateLinks<cr><leader>w', {})
    end
}
