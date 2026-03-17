require('init-plugin-manager')

-- temporary: suppress lspconfig deprecation until LSP 0.11 migration is done
local _orig_deprecate = vim.deprecate
vim.deprecate = function(name, alternative, version, plugin, backtrace)
    if plugin == "nvim-lspconfig" then return end
    _orig_deprecate(name, alternative, version, plugin, backtrace)
end

require('configure-plugins')
require('options')
require('mappings')
