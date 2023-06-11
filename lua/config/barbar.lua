require('barbar').setup({
    icons = {
        buffer_index = true,
        button = '',
        separator = {left = '▌', right = ''},
        inactive = {
            separator = {left = '▏', right = ''}
        },
        visible = {
            separator = {left = '▏', right = ''}
        },
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true, icon = '✘'},
            [vim.diagnostic.severity.WARN] = {enabled = true, icon = '▲'},
        },
        gitsigns = {
            added = {enabled = true, icon = '+'},
            changed = {enabled = true, icon = '~'},
            deleted = {enabled = true, icon = '-'},
        },
        filetype = {
            enabled = true,
            custom_colors = true,
        },
    },
})

local function hi(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local currentDefault = {bg='#2E3440', fg='#88C0D0'}
local visibleDefault = {bg='#2E3440', fg='#D8DEE9'}
local inactiveDefault = {bg='#4C566A', fg='#2E3440'}
local alternateDefault = {bg='#4C566A', fg='#5E81AC'}

local visibleModified = {bg='#2E3440', fg='#B48EAD'}
local inactiveModified = {bg='#4C566A', fg='#B48EAD'}

local visibleError = {bg='#2E3440', fg='#BF616A'}
local inactiveError = {bg='#4C566A', fg='#BF616A'}
local visibleWarning = {bg='#2E3440', fg='#EBCB8B'}
local inactiveWarning = {bg='#4C566A', fg='#EBCB8B'}

hi('BufferTabpageFill', {bg='#4C566A'})

hi('BufferCurrent', currentDefault)
hi('BufferCurrentIcon', currentDefault)
hi('BufferCurrentIndex', currentDefault)
hi('BufferCurrentMod', visibleModified)
hi('BufferCurrentSign', currentDefault)
hi('BufferCurrentTarget', visibleError)
hi('BufferCurrentERROR', visibleError)
hi('BufferCurrentWARN', visibleWarning)

hi('BufferVisible', visibleDefault)
hi('BufferVisibleIcon', visibleDefault)
hi('BufferVisibleIndex', visibleDefault)
hi('BufferVisibleMod', visibleModified)
hi('BufferVisibleSign', visibleDefault)
hi('BufferVisibleTarget', visibleError)
hi('BufferVisibleERROR', visibleError)
hi('BufferVisibleWARN', visibleWarning)

hi('BufferInactive', inactiveDefault)
hi('BufferInactiveIcon', inactiveDefault)
hi('BufferInactiveIndex', inactiveDefault)
hi('BufferInactiveMod', inactiveModified)
hi('BufferInactiveSign', {bg='#4C566A', fg='#434C5E'})
hi('BufferInactiveTarget', inactiveError)
hi('BufferInactiveERROR', inactiveError)
hi('BufferInactiveWARN', inactiveWarning)

hi('BufferAlternate', alternateDefault)
hi('BufferAlternateIcon', alternateDefault)
hi('BufferAlternateIndex', alternateDefault)
hi('BufferAlternateMod', inactiveModified)
hi('BufferAlternateSign', alternateDefault)
hi('BufferAlternateTarget', inactiveError)
hi('BufferAlternateERROR', inactiveError)
hi('BufferAlternateWARN', inactiveWarning)
