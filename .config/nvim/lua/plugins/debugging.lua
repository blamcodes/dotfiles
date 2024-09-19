return {
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {},
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            {
                'mason-nvim-dap.nvim',
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, {
                        'python',
                    })
                end,
            },
        },
        opts = {
            include_configs = false,
            console = 'internalConsole',
        },
        config = function()
            local dap = require("dap")
            require("dap-python").setup("python")

            -- DAP Configurations
            table.insert(dap.configurations.python, {
                name = "Python: Gunicorn",
                type = "python",
                request = "launch",
                module = "gunicorn",
                args = { "manawa", "--bind=0.0.0.0", "--port=3000", '--reload', '--workers=1' },
                subProcess = true,
                justMyCode = true,
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-jdtls",

            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dapui").setup()
            -- require("dap-python").setup("python")

            -- -- DAP Configurations
            -- table.insert(dap.configurations.python, {
            --     name = "Python: Gunicorn",
            --     type = "python",
            --     python = "/home/lamb6/.pyenv/shims/python",
            --     request = "launch",
            --     module = "gunicorn",
            --     args = { "manawa", "--bind=0.0.0.0", "--port=3000", '--reload', '--workers=1' },
            --     subProcess = false,
            --     justMyCode = true,
            -- })

            -- Dapui
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Keybinds
            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})
            vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
            vim.keymap.set("n", "<Leader>do", dap.step_over, {})
        end,
    },
}
