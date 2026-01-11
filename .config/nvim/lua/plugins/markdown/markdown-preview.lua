-- install with yarn or npm
return { -- For `plugins.lua` users.
  {
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    -- ft = { "markdown", "markdown_inline", "codecompanion" },
    -- For `nvim-treesitter` users.
    priority = 49,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion", "markdown_inline" },
        ignore_buftypes = {},
      },
      latex = {
        enable = false
      },
      --@type markview.config.html.container_elements
      container_elements = {
        enable = true,

        ["^a$"] = {
          on_opening_tag = { conceal = "", virt_text_pos = "inline", virt_text = { { "", "MarkviewHyperlink" } } },
          on_node = { hl_group = "MarkviewHyperlink" },
          on_closing_tag = { conceal = "" },
        },
        ["^b$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "Bold" },
          on_closing_tag = { conceal = "" },
        },
        ["^code$"] = {
          on_opening_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { " ", "MarkviewInlineCode" } } },
          on_node = { hl_group = "MarkviewInlineCode" },
          on_closing_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { " ", "MarkviewInlineCode" } } },
        },
        ["^em$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "@text.emphasis" },
          on_closing_tag = { conceal = "" },
        },
        ["^i$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "Italic" },
          on_closing_tag = { conceal = "" },
        },
        ["^mark$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "MarkviewPalette1" },
          on_closing_tag = { conceal = "" },
        },
        ["^pre$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "Special" },
          on_closing_tag = { conceal = "" },
        },
        ["^strong$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "@text.strong" },
          on_closing_tag = { conceal = "" },
        },
        ["^sub$"] = {
          on_opening_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { "↓[", "MarkviewSubscript" } } },
          on_node = { hl_group = "MarkviewSubscript" },
          on_closing_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { "]", "MarkviewSubscript" } } },
        },
        ["^sup$"] = {
          on_opening_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { "↑[", "MarkviewSuperscript" } } },
          on_node = { hl_group = "MarkviewSuperscript" },
          on_closing_tag = { conceal = "", hl_mode = "combine", virt_text_pos = "inline", virt_text = { { "]", "MarkviewSuperscript" } } },
        },
        ["^u$"] = {
          on_opening_tag = { conceal = "" },
          on_node = { hl_group = "Underlined" },
          on_closing_tag = { conceal = "" },
        },
      },

      -- For blink.cmp's completion
      -- source
      -- dependencies = {
      --     "saghen/blink.cmp"
      -- },
    },
    config = function(_, opts)
      require("markview").setup(opts)
    end,

  },
  -- {
  --   "3rd/diagram.nvim",
  --   dependencies = {
  --     "3rd/image.nvim",
  --     build = false,
  --     opts = {
  --       processor = "magick_cli",
  --
  --     }
  --   },
  --   opts = {},
  -- }
}
