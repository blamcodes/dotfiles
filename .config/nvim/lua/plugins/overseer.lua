return {
  'stevearc/overseer.nvim',
  -- lazy = true,
  keys = {
    { "<leader>Ot", "<cmd>OverseerToggle right<CR>", desc = "Toggle Overseer"},
    { "<leader>Ob", "<cmd>OverseerLoadBundle<CR>", desc = "Load Overseer Bundle"},
    { "<leader>Or", "<cmd>OverseerRun<CR>", desc = "Run Overseer Command"},
  },
  opts = {},
}
