return {
  "echasnovski/mini.diff",
  enabled = false,
  config = function()
    local diff = require("mini.diff")
    diff.setup({
      view = {
        -- Visualization style. Possible values are 'sign' and 'number'.
        -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
        style = 'sign',

        -- Signs used for hunks with 'sign' view
        signs = { add = '▒', change = '▒', delete = '▒' },

        -- Priority of used visualization extmarks
        priority = 199,
      },
      -- Disabled by default
      source = nil
    })
  end,
}
