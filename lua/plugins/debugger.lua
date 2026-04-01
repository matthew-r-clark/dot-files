return {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
        'rcarriga/nvim-dap-ui',

        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
    },
    keys = {
        -- Session / Flow
        {
            '<leader>dc',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Continue/Start',
        },
        {
            '<leader>dq',
            function()
                require('dap').terminate()
            end,
            desc = 'Debug: Quit/Terminate Session',
        },
        {
            '<leader>dL',
            function()
                require('dap').run_last()
            end,
            desc = 'Debug: Run Last',
        },
        {
            '<leader>dC',
            function()
                require('dap').run_to_cursor()
            end,
            desc = 'Debug: Run to Cursor',
        },
        -- Stepping
        {
            '<leader>dj', -- vim down
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<leader>dk', -- vim up
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>dl', -- vim right
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over',
        },
        {
            '<leader>dh', -- vim left
            function()
                require('dap').step_back()
            end,
            desc = 'Debug: Step Back',
        },
        -- goto_() uses cursor line when called with no args
        {
            '<leader>dg',
            function()
                require('dap').goto_()
            end,
            desc = 'Debug: Goto Line',
        },
        -- Call stack navigation
        {
            '<leader>du',
            function()
                require('dap').up()
            end,
            desc = 'Debug: Up in Call Stack',
        },
        {
            '<leader>dd',
            function()
                require('dap').down()
            end,
            desc = 'Debug: Down in Call Stack',
        },
        -- Breakpoints
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>dB',
            function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = 'Debug: Set Conditional Breakpoint',
        },
        {
            '<leader>dp',
            function()
                require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end,
            desc = 'Debug: Set Log Point',
        },
        {
            '<leader>dx',
            function()
                require('dap').clear_breakpoints()
            end,
            desc = 'Debug: Clear All Breakpoints',
        },
        -- UI & Tools
        {
            '<leader>de',
            function()
                require('dapui').eval()
            end,
            mode = { 'n', 'v' },
            desc = 'Debug: Evaluate Expression',
        },
        {
            '<leader>dU',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: Toggle UI',
        },
        {
            '<leader>dR',
            function()
                require('dap').repl.open()
            end,
            desc = 'Debug: Open REPL',
        },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'js',
                'js-debug-adapter',
            },
        }

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
            layouts = {
                {
                    elements = {
                        { id = 'repl', size = 0.7 },
                        { id = 'breakpoints', size = 0.3 },
                    },
                    position = 'bottom',
                    size = 15,
                },
            },
        }

        -- Change breakpoint icons
        -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
        -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
        -- local breakpoint_icons = vim.g.have_nerd_font
        --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
        -- for type, icon in pairs(breakpoint_icons) do
        --   local tp = 'Dap' .. type
        --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
        -- end

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup {
            delve = {
                -- On Windows delve must be run attached or it crashes.
                -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
                detached = vim.fn.has 'win32' == 0,
            },
        }

        dap.adapters['pwa-node'] = {
            type = 'server',
            host = '::1', -- The host the adapter should connect to
            port = '${port}', -- Replace with the port you're using (e.g., 8130)
            executable = {
                -- command = 'node',
                -- args = {
                --     vim.fn.stdpath('data') .. '/lazy/vscode-js-debug/out/src/vsDebugServer.js',
                -- },
                command = 'js-debug-adapter',
                args = {
                    '${port}',
                },
            },
        }

        for _, language in ipairs({ 'typescript', 'javascript' }) do
            require('dap').configurations[language] = {
                -- https://github.com/mxsdev/nvim-dap-vscode-js?tab=readme-ov-file#configurations
                -- {
                --     type = 'pwa-node',
                --     request = 'launch',
                --     name = 'Launch file',
                --     program = '${file}',
                --     cwd = '${workspaceFolder}',
                -- },
                {
                    type = 'pwa-node',
                    address = '127.0.0.1',
                    port = 9228,
                    request = 'attach',
                    name = 'Docker: attach to node (subscriptions api)',
                    remoteRoot = '/app/src',
                    localRoot = '${workspaceFolder}/src',
                    restart = true,
                    skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
                },
                {
                    type = 'pwa-node',
                    address = '127.0.0.1',
                    port = 9229,
                    request = 'attach',
                    name = 'Docker: attach to node (orders api)',
                    remoteRoot = '/app',
                    localRoot = '${workspaceFolder}',
                    restart = true,
                    skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
                },
                {
                    type = 'pwa-node',
                    address = '127.0.0.1',
                    port = 9230,
                    request = 'attach',
                    name = 'Docker: attach to node (users api)',
                    remoteRoot = '/app',
                    localRoot = '${workspaceFolder}',
                    restart = true,
                    skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
                },
            }
        end

        require('dap.ext.vscode').json_decode = require('json5').parse
    end,
}
