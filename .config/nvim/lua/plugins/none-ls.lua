return {
  "nvimtools/none-ls.nvim",
  enabled = false,
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Javascript
        -- @todo fix this: null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.formatting.prettier,

        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,

        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.hadolint,
        -- null_ls.builtins.formatting.snyk,
        null_ls.builtins.formatting.trivy,
        -- null_ls.builtins.formatting.yamllint,

      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
