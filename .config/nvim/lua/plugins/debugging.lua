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


      -- dap.adapters["pwa-node"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = 9229,
      --   executable = {
      --     command = vim.fn.exepath "js-debug-adapter",
      --     args = { 9229 },
      --   }
      -- }

      -- for _, language in ipairs { "typescript", "javascript" } do
      --   dap.configurations[language] = {
      --     {
      --       type = "pwa-node",
      --       request = "attach",
      --       name = "Docker Node.js Launch",
      --       address = "localhost",
      --       port = 9229,
      --       skipfiles = {
      --         "<node_internals>/**"
      --       },
      --       remoteRoot = "/home/haledev/hale-framework",
      --       cwd = "${workspaceFolder}",
      --       sourceMaps = true,
      --       -- websocketAddress = "ws://127.0.0.1:9229/62479377-9b24-4eb6-a590-b15c5600b70",
      --       protocol = 'inspector',
      --       outFiles = { "${workspaceFolder}/build/framework/js/*.js" },
      --       sourceMapPathOverrides = {
      --         ["./*"] = "${workspaceFolder}"
      --       }
      --
      --       -- function()
      --       --     return string.match(
      --       --         vim.api.nvim_exec('!docker logs [conatiner-name]|& grep -oE "ws.*" | tail -1', true),
      --       --         "ws:.*"
      --       --     )
      --       -- end,
      --     },
      --     {
      --       type = "pwa-node",
      --       request = "attach",
      --       name = "[node] Attach",
      --       processId = require("dap.utils").pick_process,
      --       cwd = "${workspaceFolder}",
      --     },
      --     {
      --       type = "pwa-node",
      --       request = "launch",
      --       name = "Debug Jest Tests",
      --       -- trace = true, -- include debugger info
      --       runtimeExecutable = "node",
      --       runtimeArgs = {
      --         "./node_modules/jest/bin/jest.js",
      --         "--runInBand",
      --       },
      --       rootPath = "${workspaceFolder}",
      --       cwd = "${workspaceFolder}",
      --       console = "integratedTerminal",
      --       internalConsoleOptions = "neverOpen",
      --     },
      --   }
      -- end
      --
      -- dap.configurations.java = {
      --   {
      --     type = 'java',
      --     request = 'attach',
      --     name = "Debug (Attach) - Remote",
      --     projectName = "luau",
      --     hostName = "localhost",
      --     port = 5005,
      --   },
      -- }
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
      local dotnet = require("easy-dotnet")
      local debug_dll = nil

      local function rebuild_project(co, path)
        local spinner = require("easy-dotnet.ui-modules.spinner").new()
        spinner:start_spinner("Building")
        vim.fn.jobstart(string.format("dotnet build %s", path), {
          on_exit = function(_, return_code)
            if return_code == 0 then
              spinner:stop_spinner("Built successfully")
            else
              spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
              error("Build failed")
            end
            coroutine.resume(co)
          end,
        })
        coroutine.yield()
      end

      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      for _, value in ipairs({ "cs", "fsharp" }) do
        dap.configurations[value] = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            env = function()
              local dll = ensure_dll()
              local vars = dotnet.get_environment_variables(dll.project_name, dll
                .relative_project_path)
              return vars or nil
            end,
            program = function()
              local dll = ensure_dll()
              local co = coroutine.running()
              rebuild_project(co, dll.project_path)
              return dll.relative_dll_path
            end,
            cwd = function()
              local dll = ensure_dll()
              return dll.relative_project_path
            end,
          },
          {
            type = "coreclr",
            name = "attach to process - netcoredbg",
            request = "attach",
            processId = require("dap.utils").pick_process
            -- env = function()
            --   local dll = ensure_dll()
            --   local vars = dotnet.get_environment_variables(dll.project_name, dll
            --     .relative_project_path)
            --   return vars or nil
            -- end,
            -- program = function()
            --   local dll = ensure_dll()
            --   local co = coroutine.running()
            --   rebuild_project(co, dll.project_path)
            --   return dll.relative_dll_path
            -- end,
            -- cwd = function()
            --   local dll = ensure_dll()
            --   return dll.relative_project_path
            -- end,
          }
        }
      end

      dap.listeners.before['event_terminated']['easy-dotnet'] = function()
        debug_dll = nil
      end

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }

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

      vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

      -- Keybinds
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<Leader>dc", dap.continue, {})
      vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
      vim.keymap.set("n", "<Leader>do", dap.step_over, {})
    end,
  },
}
