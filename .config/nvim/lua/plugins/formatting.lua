return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylelua" },
        dockerfile = { "stylelua" },
        cs = { "csharpier"},
      },
      -- format_on_save = function(bufnr)
      --   local ignore_filetypes = { "dockerfile" }
      --   if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      --     return
      --   end
      --   -- Disable with a global or buffer-local variable
      --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      --     return
      --   end
      --   -- Disable autoformat for files in a certain path
      --   local bufname = vim.api.nvim_buf_get_name(bufnr)
      --   if bufname:match("/node_modules/") then
      --     return
      --   end
      --   return {
      --     lsp_fallback = true,
      --     async = false,
      --     timeout_ms = 500,
      --   }
      -- end
    })


    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
}
