return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    local function find_charts_dir(start_dir)
        local current_dir = start_dir or vim.fn.getcwd()

        while current_dir ~= '/' do
            local charts_dir =  current_dir .. '/Chart.yaml'

            if vim.loop.fs_stat(charts_dir) then
                print(vim.fs.dirname(charts_dir))
                return vim.fs.dirname(charts_dir)
            end

            current_dir = vim.fs.dirname(current_dir) -- Move up a directory
        end

        return nil
    end

    local pattern = '%[(.+)%] (.+): (.+)'
    local severity_map = {
        ['ERROR'] = vim.diagnostic.severity.ERROR,
        ['WARNING'] = vim.diagnostic.severity.WARN,
        ['INFO'] = vim.diagnostic.severity.INFO,
    }

    local defaults = {
        ["source"] = "helm"
    }

    local opts = {}

    lint.linters.helm_lint = {
      cmd = 'helm',
      args = {'lint', function()
          find_charts_dir(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
      end, '--quiet'},
      stdin = true,
      stream = 'stdout',
      ignore_exitcode = true,
      parser = require('lint.parser').from_pattern(
        pattern,
        { 'severity', 'file', 'message' },
        severity_map,
        defaults,
        opts
      )
    }

    lint.linters_by_ft = {
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      -- svelte = { "eslint_d" },
      -- python = { "pylint" },
      helm = { "helm_lint" }
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