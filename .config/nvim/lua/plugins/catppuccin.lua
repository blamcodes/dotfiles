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
      flavour = "macchiato",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        functions = { "italic" },
      },
      integrations = {
        treesitter = true,
      }
    })

    local colors = require("catppuccin.palettes").get_palette()
    local TelescopeColor = {
      TelescopeMatching = { fg = colors.rosewater },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

      TelescopePromptPrefix = { bg = "NONE" },
      TelescopePromptNormal = { bg = "NONE" },
      TelescopeResultsNormal = { bg = "NONE" },
      TelescopePreviewNormal = { bg = "NONE" },

      TelescopePromptBorder = { bg = "NONE", fg = colors.mantle },
      TelescopeResultsBorder = { bg = "NONE", fg = colors.mantle },
      TelescopePreviewBorder = { bg = "NONE", fg = colors.mantle },

      TelescopePromptTitle = { bg = colors.mauve, fg = colors.mantle },
      TelescopeResultsTitle = { bg = colors.green, fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.pink, fg = colors.mantle },
    }

    for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
    end

    vim.cmd.colorscheme("catppuccin")
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = "#939ab7", bold = false })
    -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#989ab7", fg = "NONE", bold = false })
    -- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#939ab7", bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#939ab7", bold = false })
    vim.api.nvim_set_hl(0, 'Folded', { fg = "#5b6078", bold = false })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg="#212121", ctermbg = "NONE"})
    vim.api.nvim_create_augroup("CursorLineTransparency", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = "CursorLineTransparency",
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#212121",  ctermbg = "NONE" })
      end,
    })
  end,
}
