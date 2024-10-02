return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({
      options = {
        theme = 'catppuccin'
      },
      sections = {
        lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress' },
        lualine_y = { 'location' },
        lualine_z = { 'datetime' }
      }
    })
  end
}
