return {
  'feline-nvim/feline.nvim',
  enable = false,
  config = function()
    local ctp_feline = require('catppuccin.special.feline')

    ctp_feline.setup()

    require("feline").setup({
      components = ctp_feline.get_statusline(),
    })
  end
}
