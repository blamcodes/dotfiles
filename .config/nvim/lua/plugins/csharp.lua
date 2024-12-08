return {
    {
      "tris203/rzls.nvim"
    },
    {
      "seblj/roslyn.nvim",
      branch = "fix-client-methods",
      ft = "cs",
      opts = {
          -- your configuration comes here; leave empty for default settings
      },
      config = function()
        local capabilities = require("lspcapabilities")
        require('roslyn').setup({
           args = {
              '--logLevel=Information',
              '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
              '--razorSourceGenerator=' .. vim.fs.joinpath(
                vim.fn.stdpath 'data' --[[@as string]],
                'mason',
                'packages',
                'roslyn',
                'libexec',
                'Microsoft.CodeAnalysis.Razor.Compiler.dll'
              ),
              '--razorDesignTimePath=' .. vim.fs.joinpath(
                vim.fn.stdpath 'data' --[[@as string]],
                'mason',
                'packages',
                'rzls',
                'libexec',
                'Targets',
                'Microsoft.NET.Sdk.Razor.DesignTime.targets'
              ),
            },
            config = {
              on_attach = require 'lspattach',
              capabilities = capabilities,
              handlers = require 'rzls.roslyn_handlers',
            },
        })
    end
  }
}

