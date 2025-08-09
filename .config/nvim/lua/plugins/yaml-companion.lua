return {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml" },
    dependencies = { 
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
    opts = {
      lspconfig = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      },
    },
    config = function ()
    end
}
