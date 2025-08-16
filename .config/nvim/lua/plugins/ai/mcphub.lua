return {
  "ravitemer/mcphub.nvim",
  -- event = "VeryLazy",
  -- enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- build = "npm install -g mcp-hub@latest",   -- Installs `mcp-hub` node binary globally
  build = "bundled_build.lua",   -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup()
  end
}
