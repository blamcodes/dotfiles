return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")
    local vim = vim


    local function find_charts_dir(start_dir)
        local current_dir = start_dir or vim.fn.getcwd()

        while current_dir ~= '/' do
            local charts_dir =  current_dir .. '/Charts'

            if vim.loop.fs_stat(charts_dir) then
                print(charts_dir)
                return charts_dir
            end

            current_dir = vim.fs.dirname(current_dir) -- Move up a directory
        end

        return nil
    end

    -- Linter Custom
    lint.linters.helmlint = {
      cmd = 'helm lint',
      stdin = true,
      stream = 'stdout', -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      cwd = find_charts_dir(vim.fs.dirname(vim.api.nvim_buf_get_name(0))),
      parser = function(output)
        local diagnostics = {}
        local ok, result = pcall(vim.json.decode, output)
        if not ok then
            return diagnostics
        end
      end
    }

    lint.linters_by_ft = {
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      -- svelte = { "eslint_d" },
      -- python = { "pylint" },
      helm = { "helmlint" }
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
