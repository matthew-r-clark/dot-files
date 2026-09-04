return { -- chat with Claude Code CLI in a split/float window
  'wtfox/claude-chat.nvim',
  config = true,
  keys = {
    { '<leader>cc', ':ClaudeChat<CR>', mode = { 'n', 'v' }, desc = 'Claude Chat' },
  },
}
