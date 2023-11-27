local AUTO_BACKUP_DELAY = 15 * 60 -- 15 minutes
local BACKUP_FILEPATH = '.vimwiki_last_backup_time'

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

vim.api.nvim_create_autocmd({ 'BufWritePost' }, { callback = auto_backup })
