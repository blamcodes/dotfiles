return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "hrsh7th/cmp-cmdline",
        config = function()
          local cmp = require("cmp")
          -- `/` cmdline setup.
          cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          })
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
              {
                name = 'cmdline',
                option = {
                  ignore_cmds = { 'Man', '!' }
                }
              }
            })
          })
        end
      },
    },
    config = function()
      local cmp = require("cmp")
      --
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_lua").load({ paths = "lua/plugins/snippets" })

      cmp.setup({
        -- snippet = {
        --   expand = function(args)
        --     require("luasnip").lsp_expand(args.body)
        --   end,
        -- },

        -- Window Appearance
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Keybinds
        mapping = cmp.mapping.preset.insert({
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        sources = cmp.config.sources({

          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              -- Check if the buffer type is 'vue'
              if ctx.filetype ~= 'vue' then
                return true
              end

              local cursor_before_line = ctx.cursor_before_line
              -- For events
              if cursor_before_line:sub(-1) == '@' then
                return entry.completion_item.label:match('^@')
                -- For props also exclude events with `:on-` prefix
              elseif cursor_before_line:sub(-1) == ':' then
                return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
              else
                return true
              end
            end
          },
          { name = "luasnip" },           -- For luasnip users.
          { name = "friendly-snippets" }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
          { name = "nvim_lsp_signature_help" },
          { name = "easy-dotnet" },
          { name = "vim-dadbod-completion" }
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  --- Auto bracket closing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "L3MON4D3/LuaSnip",
    ft = "lua",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local ls = require("luasnip")
      ls.setup({
        snip_env = {
          s = function(...)
            local snip = ls.s(...)
            table.insert(getfenv(2).ls_file_snippets, snip)
          end,
          parse = function(...)
            local snip = ls.parser.parse_snippet(...)
            table.insert(getfenv(2).ls_file_snippets, snip)
          end,
        },
      })
      require("luasnip.loaders.from_lua").load({ paths = "lua/plugins/snippets" })
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    ft = "lua",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    ft = "lua",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },

}
