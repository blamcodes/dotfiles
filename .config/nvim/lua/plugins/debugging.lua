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


            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = 9229,
                executable = {
                    command = vim.fn.exepath "js-debug-adapter",
                    args = { 9229 },
                }
            }

            for _, language in ipairs { "typescript", "javascript" } do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Docker Node.js Launch",
                        address = "localhost",
                        port = 9229,
                        skipfiles = {
                            "<node_internals>/**"
                        },
                        remoteRoot = "/home/haledev/hale-framework",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        -- websocketAddress = "ws://127.0.0.1:9229/62479377-9b24-4eb6-a590-b15c5600b70",
                        protocol = 'inspector',
                        outFiles = { "${workspaceFolder}/build/framework/js/*.js" },
                        sourceMapPathOverrides = {
                            ["./*"] = "${workspaceFolder}"
                        }

                        -- function()
                        --     return string.match(
                        --         vim.api.nvim_exec('!docker logs [conatiner-name]|& grep -oE "ws.*" | tail -1', true),
                        --         "ws:.*"
                        --     )
                        -- end,
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "[node] Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                }
            end

            dap.configurations.java = {
              {
                type = 'java';
                request = 'attach';
                name = "Debug (Attach) - Remote";
                projectName = "luau",
                hostName = "localhost";
                port = 5005;
              },
            }
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

            vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
            vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

            -- Keybinds
            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})
            vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
            vim.keymap.set("n", "<Leader>do", dap.step_over, {})
        end,
    },
}
