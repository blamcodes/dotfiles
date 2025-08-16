return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  config = function()
    local treesitter = require('nvim-treesitter')
    local function treelocation()
      return treesitter.statusline({
        indicator_size = 70,
        type_patterns = {'class', 'function', 'method'},
        separator = ' -> '
      })
    end

    require('lualine').setup({
      options = {
        theme = 'catppuccin'
      },
      sections = {
        lualine_c = { treelocation },
        lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress' },
        lualine_y = { 'location' },
        lualine_z = { 'datetime' }
      }
    })
  end
}
