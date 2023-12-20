return {
    'dcampos/cmp-snippy',
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require 'snippy'.expand_snippet(args.body)
                end
            },
            sources = {
                { name = 'snippy' }
            }
        })
    end,
}
