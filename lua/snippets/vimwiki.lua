local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function getDateFromFilename()
    return vim.fs.basename()
end

ls.add_snippets('vimwiki', {
    s('standup', {
        t('anything you want it to be'),
        f(getDateFromFilename),
    }),
})

require('snippets/javascript')
