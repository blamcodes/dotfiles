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
    ft = { "python" },
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
  -- {
  --   "leoluz/nvim-dap-go",
  --   ft = { "go" },
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --   }
  -- },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = "java",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --   }
  -- },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = "js",
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dc", "<cmd>DapContinue<CR>", desc = "DAP Continue" }
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      -- lazy spec to build "microsoft/vscode-js-debug" from source
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
      }
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = 9229,
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
            9229
          },
        }
      }
      for _, language in ipairs { "typescript", "javascript", "vue" } do
        dap.configurations[language] = {
          {
            -- use nvim-dap-vscode-js's pwa-chrome debug adapter
            type = "pwa-chrome",
            request = "launch",
            -- name of the debug action
            name = "Launch Chrome to debug client side code",
            -- default vite dev server url
            url = "localhost:5000",
            -- for TypeScript/Svelte
            -- sourceMaps = true,
            webRoot = "${workspaceFolder}",
            -- protocol = "inspector",
            port = 9222,
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
            name = "Launch File",
            -- trace = true, -- include debugger info
            program = "${file}",
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
      -- vim.keymap.set("n", "<Leader>dc", dap.continue, {})
      vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
      vim.keymap.set("n", "<Leader>do", dap.step_over, {})

      vim.keymap.set("n", "<leader>de", ":lua require'dapui'.elements.watches.add(vim.fn.expand('<cexpr>'))<cr>",
        { silent = true })
      vim.keymap.set("n", "<C-k>", ":lua require'dapui'.eval()<cr>", { silent = true })
    end,
  },
}
