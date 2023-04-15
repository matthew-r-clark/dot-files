local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('javascript', {
    s('useeffect', {
        t({
            'useEffect(() => {',
            '\t',
        }),
        i(0),
        t({
            '\t',
            '}, []);',
        }),
    })
})
