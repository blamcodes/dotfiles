return {
  "nvim-neotest/neotest",
  enabled = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "Issafalcon/neotest-dotnet",
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({
          dap = {
          -- -- Extra arguments for nvim-dap configuration
          -- -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          --   args = {justMyCode = false },
          -- -- Enter the name of your dap adapter, the default value is netcoredbg
          --   adapter_name = "netcoredbg"
          },
          -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
          -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
          custom_attributes = {
            xunit = { "MyCustomFactAttribute" },
            nunit = { "MyCustomTestAttribute" },
            mstest = { "MyCustomTestMethodAttribute" }
          },
          -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
          dotnet_additional_args = {
            "--verbosity detailed"
          },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = "project" -- Default
        })
      }
    })
  end,
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },

}
