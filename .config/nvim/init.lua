-- Lazy NVIM Installation
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("global")

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
    -- { import = "plugins.python" },
    { import = "plugins.markdown" },
    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("autocmds")

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
            on_attach = function()
            end,
            capabilities = capabilities,
            handlers = require 'rzls.roslyn_handlers',
          },
      })
