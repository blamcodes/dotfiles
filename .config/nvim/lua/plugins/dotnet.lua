return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    -- enabled = false,
    ft = { "cs" },
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    config = function()
      require("easy-dotnet").setup({
        --Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
        lsp = {
          enabled = false,
        },
        get_sdk_path = function()
          return '/usr/share/dotnet/sdk/9.0.306'
        end,
        test_runner = {
          ---@type "split" | "float" | "buf"
          viewmode = "split",
          -- vstest_path = "/usr/share/dotnet/sdk/8.0.408/vstest.console.dll",
          enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
          noBuild = true,
          noRestore = true,
          icons = {
            passed = "",
            skipped = "",
            failed = "",
            success = "✅",
            reload = "",
            test = "🧪",
            sln = "󰘐",
            project = "󰘐",
            dir = "📁",
            package = "",
          },
          mappings = {
            run_test_from_buffer = { lhs = "<leader>Er", desc = "run test from buffer" },
            filter_failed_tests = { lhs = "<leader>ef", desc = "filter failed tests" },
            debug_test = { lhs = "<leader>ed", desc = "debug test" },
            go_to_file = { lhs = "G", desc = "got to file" },
            run_all = { lhs = "<leader>R", desc = "run all tests" },
            run = { lhs = "<leader>r", desc = "run test" },
            peek_stacktrace = { lhs = "<leader>Ep", desc = "peek stacktrace of failed test" },
            expand = { lhs = "o", desc = "expand" },
            expand_node = { lhs = "E", desc = "expand node" },
            expand_all = { lhs = "-", desc = "expand all" },
            collapse_all = { lhs = "W", desc = "collapse all" },
            close = { lhs = "q", desc = "close testrunner" },
            refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
          },
          --- Optional table of extra args e.g "--blame crash"
          additional_args = {}
        },
        secrets = {
          path = function()
            return "~/.microsoft/usersecrets/d8de92d0-6786-481a-8bb8-66243b1dbffc/secrets.json"
          end
        },
        csproj_mappings = true,
        fsproj_mappings = true,
        auto_bootstrap_namespace = {
          type = "file_scoped",
          enabled = true,
        },
        picker = "snacks"
      })
      -- Define a key mapping to open the test runner
      vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>lua require("easy-dotnet").testrunner()<CR><C-W>L',
        { noremap = true, silent = true })

      -- local M = {}
      --
      -- --- Rebuilds the project before starting the debug session
      -- ---@param co thread
      -- local function rebuild_project(co, path)
      --     local spinner = require("easy-dotnet.ui-modules.spinner").new()
      --     spinner:start_spinner("Building")
      --     vim.fn.jobstart(string.format("dotnet build %s", path), {
      --         on_exit = function(_, return_code)
      --             if return_code == 0 then
      --                 spinner:stop_spinner("Built successfully")
      --             else
      --                 spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
      --                 error("Build failed")
      --             end
      --             coroutine.resume(co)
      --         end,
      --     })
      --     coroutine.yield()
      -- end

      --     M.register_net_dap = function()
      --         local dap = require("dap")
      --         local dotnet = require("easy-dotnet")
      --         local debug_dll = nil
      --
      --         local function ensure_dll()
      --             if debug_dll ~= nil then
      --                 return debug_dll
      --             end
      --             local dll = dotnet.get_debug_dll()
      --             debug_dll = dll
      --             return dll
      --         end
      --
      --         for _, value in ipairs({ "cs", "fsharp" }) do
      --             dap.configurations[value] = {
      --                 {
      --                     type = "coreclr",
      --                     name = "launch - netcoredbg",
      --                     request = "launch",
      --                     env = function()
      --                         local dll = ensure_dll()
      --                         local vars = dotnet.get_environment_variables(dll.project_name, dll
      --                             .relative_project_path)
      --                         return vars or nil
      --                     end,
      --                     program = function()
      --                         local dll = ensure_dll()
      --                         local co = coroutine.running()
      --                         rebuild_project(co, dll.project_path)
      --                         return dll.relative_dll_path
      --                     end,
      --                     cwd = function()
      --                         local dll = ensure_dll()
      --                         return dll.relative_project_path
      --                     end,
      --
      --                 }
      --             }
      --         end
      --
      --         dap.listeners.before['event_terminated']['easy-dotnet'] = function()
      --             debug_dll = nil
      --         end
      --
      --         dap.adapters.coreclr = {
      --             type = "executable",
      --             command = "netcoredbg",
      --             args = { "--interpreter=vscode" },
      --         }
      --     end
      -- end
    end

  }
}
