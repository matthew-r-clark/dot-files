local wilder = require('wilder')

wilder.setup({
    modes = {':'},
})

wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
        border = 'rounded',
        highlights = {
            border = 'Normal',
        },
        left = {' '},
        right = {' ', wilder.popupmenu_scrollbar()},
    })
))

wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
        })
    ),
})
