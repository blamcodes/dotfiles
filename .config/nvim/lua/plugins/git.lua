return {
  {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    config = function()
      require("statuscol").setup({})
    end,
  },
  {
    {
      "ldelossa/gh.nvim",
      keys = {
        { '<leader>gH', "<cmd>GHOpenPR", desc = "Open Github PR" },

      },
      dependencies = {
        {
          "ldelossa/litee.nvim",
          config = function()
            require("litee.lib").setup()
          end,
        },
      },
      config = function()
        require("litee.gh").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      -- enabled = false,
      config = function()
        local gitsigns = require('gitsigns')

        gitsigns.setup({
          signcolumn = true,
          linehl = false,
          current_line_blame_opts = {
            delay = 500,
          }
        })

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        local module = "GitSigns"
        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = module .. ": Stage Buffer" })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = module .. ": Preview" })
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end,
          { desc = module .. ": Blame Line" })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = module .. ": Diff This" })
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = module .. ": Toggle Deleted" })
        vim.keymap.set({ "n" }, "<leader>hl", ":0GcLog<CR>")
        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  }

}
