return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    'nvim-neotest/neotest-jest',
  },
  keys = {
    { '<leader>Tr', '<cmd>Neotest run<CR>', desc = "Neotest: Run" },
    { '<leader>To', '<cmd>Neotest output-panel<CR>', desc = "Neotest: Output Panel" },

  },
  config = function()
    require("neotest").setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm run test:unit --",
          -- jestConfigFile = "custom.jest.config.ts",
          -- env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd() .. '/src/IronSight.Web/ClientApp'
          end
        })
      }
    })
  end
}
