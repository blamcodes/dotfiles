return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { '<leader>ai', "<cmd>CodeCompanionChat Toggle<cr>", "Open AI Chat" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

    },
    opts = {
      adapters = {
        anthropic = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY"
              }
            })
          end
        }
      },
      strategies = {
        chat = {
          slash_commands = {
            ["buffer"] = {
              opts = {
                provider = "snacks"
              }
            }
          }
        }
      }
    },
    config = function()
      require("codecompanion").setup({
        opts = {
          log_level = "DEBUG", -- or "TRACE",
        },
        -- ======================================================================
        -- Extensions
        -- ======================================================================
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = false
            },
          }
        },
        strategies = {
          chat = {
            adapter = {
              name = "copilot",
              model = "gpt-4o",
            },
            slash_commands = {
              ["buffer"] = {
                opts = {
                  provider = "snacks"
                }
              },
              ["file"] = {
                opts = {
                  provider = "snacks"
                }
              },
            }
          }
        },
      })

      -- Keymaps
      vim.api.nvim_set_keymap("v", "<leader>Ai", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end
  }
}
