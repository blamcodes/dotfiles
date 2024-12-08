return {
   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    enabled = false,
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
      vim.keymap.set(
        "",
        "<Leader>dl",
        require("lsp_lines").toggle,
        { desc = "Toggle lsp_lines" }
      )
    end,
}
