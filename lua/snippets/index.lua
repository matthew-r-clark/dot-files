local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node

ls.add_snippets('all', {
    s('test_snippet', t('anything you want it to be')),
})

require('snippets/javascript')
require('snippets/vimwiki')
