return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      float = {
        transparent = true,
      },
      flavour = "auto",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        functions = { "italic" },
      },
      integrations = {
        treesitter = true,
      }
    })

    require('lualine').setup {
        options = {
            theme = "catppuccin"
        },
        global_status = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        sections = {
          lualine_c = {},

          lualine_x = { },
          lualine_y =  { 'location', 'filetype' },
          lualine_z = { function() return vim.fn.getcwd() end }
        }
    }

    require('lualine').hide({
      place = { 'dashboard', 'snacks_dashboard`'}, -- The segment this change applies to.
      unhide = false,  -- whether to re-enable lualine again/
    })
    -- local colors = require("catppuccin.palettes").get_palette()

    vim.cmd.colorscheme("catppuccin")

    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = "#939ab7", bold = false })
    -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#989ab7", fg = "NONE", bold = false })
    -- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#939ab7", bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#939ab7", bold = false })
    vim.api.nvim_set_hl(0, 'Folded', { fg = "#5b6078", bold = false })
    -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#212121", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = "none", blend = 20 })
    -- vim.api.nvim_create_augroup("CursorLineTransparency", { clear = true })
    -- vim.api.nvim_create_autocmd("ColorScheme", {
    --   group = "CursorLineTransparency",
    --   pattern = "*",
    --   callback = function()
    --     vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#212121", ctermbg = "NONE" })
    --   end,
    -- })
  end,
}
