require('nightfox').setup({
    options = {
        transparent = true,
        dim_inactive = true,
        styles = {
            keywords = 'bold',
        },
    },
    groups = {
        all = {
            CursorLine = { bg = '#3B4252' },
            CursorColumn = { bg = '#3B4252' },
            NormalNC = { bg = '#181E2A' },
        },
    },
})
