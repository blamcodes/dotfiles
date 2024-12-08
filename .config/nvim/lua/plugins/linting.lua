return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    -- other config
    linters = {
      eslint_d = {
        args = {
          '--no-warn-ignored', -- <-- this is the key argument
          '--format',
          'json',
          '--stdin',
          '--stdin-filename',
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
      },
    },
  },
  config = function()
    local lint = require("lint")

    -- Old Helm Stuff
    -- local function find_charts_dir(start_dir)
    --   local current_dir = start_dir or vim.fn.getcwd()
    --
    --   while current_dir ~= '/' do
    --     local charts_dir = current_dir .. '/Chart.yaml'
    --
    --     if vim.loop.fs_stat(charts_dir) then
    --       print(vim.fs.dirname(charts_dir))
    --       return vim.fs.dirname(charts_dir)
    --     end
    --
    --     current_dir = vim.fs.dirname(current_dir) -- Move up a directory
    --   end
    --
    --   return nil
    -- end
    --


    local defaults = {
      ["source"] = "helm"
    }

    local opts = {}

    -- Helm Stuff
    -- lint.linters.helm_lint = {
    --   cmd = 'helm',
    --   args = { 'lint', function()
    --     find_charts_dir(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
    --   end, '--quiet' },
    --   stdin = true,
    --   stream = 'stdout',
    --   ignore_exitcode = true,
    --   parser = require('lint.parser').from_pattern(
    --     pattern,
    --     { 'severity', 'file', 'message' },
    --     severity_map,
    --     defaults,
    --     opts
    --   )
    -- }

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      Dockerfile = { "hadolint", "snyk_iac", "trivy" },
      -- svelte = { "eslint_d" },
      -- python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
