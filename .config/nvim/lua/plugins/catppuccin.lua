return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "macchiato",
      transparent_background = true,
      -- integrations = {
      --     telescope = {
      --         enabled = true,
      --         style = "nvchad"
      --     }
      -- }
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
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.mantle, fg = "NONE", bold = false })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#939ab7", bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#939ab7", bold = false })
  end,
}
