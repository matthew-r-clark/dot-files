return { -- code navigation
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>f', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash search' },
    -- learn how these work before enabling:
    -- { 'F', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash select' },
    -- { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    -- { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    -- { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
  },
}
