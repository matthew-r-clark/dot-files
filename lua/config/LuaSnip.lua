local ls = require('luasnip')

ls.filetype_extend('javascript', { 'javascriptreact' })
ls.filetype_extend('javascript', { 'html' })

require('luasnip.loaders.from_vscode').lazy_load()
require('snippets/index')
