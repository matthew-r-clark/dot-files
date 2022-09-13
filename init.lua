vim.cmd('source ~/.vim/.vimrc');

require('nvim-tree').setup({
    open_on_setup = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    hijack_unnamed_buffer_when_opening = true,
    auto_reload_on_write = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        -- ignore_list = [],
    },
    renderer = {
        icons = {
            show = {
                git = true,
            },
        },
    },
});
require('nvim-web-devicons').setup({ default = true });
