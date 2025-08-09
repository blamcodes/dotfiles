return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      ---@class snacks.picker.grep.Config
      picker = {
        grep = {
          cmd = "rg",
          title = "Ripgrep"
        },
      },

    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    specs = {
      {
        "folke/snacks.nvim",
        -- enabled=false,
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
          bigfile = { enabled = true },
          zen = { enabled = true },
          dashboard = {
            width = 60,
            row = nil,                                                                   -- dashboard position. nil for center
            col = nil,                                                                   -- dashboard position. nil for center
            pane_gap = 4,                                                                -- empty columns between vertical panes
            autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
            -- These settings are used by some built-in sections
            preset = {
              -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
              ---@type fun(cmd:string, opts:table)|nil
              pick = nil,
              -- Used by the `keys` section to show keymaps.
              -- Set your custom keymaps here.
              -- When using a function, the `items` argument are the default keymaps.
              ---@type snacks.dashboard.Item[]
              keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
              },

              -- Used by the `header` section
              header = [[████ ██████           █████      ██
    ███████████             █████ 
    █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
   ███████████ ███    ███ █████████ █████ █████ ████ █████
  ██████  █████████████████████ ████ █████ █████ ████ ██████]]
            },
          },
          -- item field formatters
          formats = {
            icon = function(item)
              if item.file and item.icon == "file" or item.icon == "directory" then
                return M.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
          },
          indent = { enabled = false },
          rename = { enabled = true },
          dim = { enabled = true },
          git = { enabled = true },
          terminal = { enabled = true },
          scratch = { enabled = true },
          scope = { enabled = true },
          -- statuscolumn = {
          --   left = { "mark", "sign" }, -- priority of signs on the left (high to low)
          --   right = { "fold", "git" }, -- priority of signs on the right (high to low)
          --   folds = {
          --     open = true,             -- show open fold icons
          --     git_hl = true,           -- use Git Signs hl for fold icons
          --   },
          --   git = {
          --     -- patterns to match Git signs
          --     patterns = { "GitSign", "MiniDiffSign" },
          --   },
          --   refresh = 50, -- refresh at most every 50ms
          -- },
          input = { enabled = true },
          notifier = { enabled = true },
          quickfile = { enabled = true },
          scroll = { enabled = true },
          words = { enabled = true },
          lazygit = { enabled = true },
          picker = {
            files = {
              cmd = "fd"
            },
            win = {
              input = {
                keys = {
                  ["<a-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                }
              }
            },
            actions = {
              flash = function(picker)
                require("flash").jump({
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                })
              end,
            },
            matcher = {
              fuzzy = true,          -- use fuzzy matching
              smartcase = true,      -- use smartcase
              ignorecase = true,     -- use ignorecase
              sort_empty = false,    -- sort results when the search string is empty
              filename_bonus = true, -- give bonus for matching file names (last part of the path)
              file_pos = true,       -- support patterns like `file:line:col` and `file:line`
              -- the bonusses below, possibly require string concatenation and path normalization,
              -- so this can have a performance impact for large lists and increase memory usage
              cwd_bonus = true,      -- give bonus for matching files in the cwd
              frecency = true,       -- frecency bonus
              history_bonus = false, -- give more weight to chronological order
            },
            ui_select = true,
            ---@class snacks.picker.formatters.Config
            formatters = {
              text = {
                ft = nil, ---@type string? filetype for highlighting
              },
              file = {
                filename_first = true, -- display filename before the file path
                truncate = 80,         -- truncate the file path to (roughly) this length
                filename_only = false, -- only show the filename
                icon_width = 2,        -- width of the icon (in characters)
              },
              selected = {
                show_always = false, -- only show the selected column when there are multiple selections
                unselected = true,   -- use the unselected icon for unselected items
              },
              severity = {
                icons = true,  -- show severity icons
                level = false, -- show severity level
                ---@type "left"|"right"
                pos = "left",  -- position of the diagnostics
              },
            },
            ---@class snacks.picker.debug
            debug = {
              scores = false,   -- show scores in the list
              leaks = false,    -- show when pickers don't get garbage collected
              explorer = false, -- show explorer debug info
              files = false,    -- show file debug info
              grep = false,     -- show file debug info
              proc = false,     -- show proc debug info
              extmarks = false, -- show extmarks errors
            },

          },

        },
        keys = {
          -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-examples
          { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
          { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
          { "<leader>.",       function() Snacks.scratch.open({ ft = "markdown" }) end,                desc = "Toggle Scratch Buffer" },
          { "<leader>,",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
          { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
          { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
          { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
          { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },

          { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
          { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
          { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
          { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",              mode = { "n", "t" } },
          { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",              mode = { "n", "t" } },
          -- Find
          { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
          -- Grep
          { "<leader>fb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
          { "<leader>fB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
          { "<leader>fg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
          { "<leader>fw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",    mode = { "n", "x" } },
          -- Top Pickers & Explorer
          { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
          { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
          { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
          { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
          { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
          { "<leader>p",       function() Snacks.picker.files() end,                                   desc = "Smart Find Files" },
          { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },

          { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
          { "<c-n>",           function() Snacks.explorer() end,                                       desc = "File Explorer" },
          { "<leader>fR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },

          -- search
          { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
          { "<leader>fb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
          { "<leader>fd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
          { "<leader>fD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
          { '<leader>f/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
          { "<leader>fq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
          { "<leader>fm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },

          -- git
          { "<leader>Gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
          { "<leader>gb",      function() Snacks.git.blame_line() end,                                 desc = "Git Blame Line" },
          { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
          { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
          { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
          { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
          { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
          { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },

          { "<leader>gX",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                  mode = { "n", "v" } },
          { "<leader>gf",      function() Snacks.lazygit.log_file() end,                               desc = "Lazygit Current File History" },
          { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
          -- { "<leader>gl",      function() Snacks.lazygit.log() end,                     desc = "Lazygit Log (cwd)" },
          -- LSP
          { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
          { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
          { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                        desc = "References" },
          { "gi",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
          { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
          { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
          { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        },
        init = function()
          vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
              -- Setup some globals for debugging (lazy-loaded)
              _G.dd = function(...)
                Snacks.debug.inspect(...)
              end
              _G.bt = function()
                Snacks.debug.backtrace()
              end
              vim.print = _G.dd -- Override print to use snacks for `:=` command

              -- Create some toggle mappings
              Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
              Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
              Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
              Snacks.toggle.diagnostics():map("<leader>ud")
              Snacks.toggle.line_number():map("<leader>ul")
              Snacks.toggle.option("conceallevel",
                { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
              Snacks.toggle.treesitter():map("<leader>uT")
              Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                "<leader>ub")
              Snacks.toggle.inlay_hints():map("<leader>uh")
              Snacks.toggle.indent():map("<leader>ug")
              Snacks.toggle.dim():map("<leader>uD")
            end,
          })
        end,
      }

    }
  },


}
