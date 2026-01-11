local constants = {
  SYSTEM_ROLE = "system",
  USER_ROLE = "user"
}

return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { '<leader>ai', "<cmd>CodeCompanionChat Toggle<cr>", "Open AI Chat" },
    },
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "ravitemer/mcphub.nvim"
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

    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          acp = {
            codex = function()
              return require("codecompanion.adapters").extend("codex", {
                defaults = {
                  auth_method = "chatgpt", -- "openai-api-key"|"codex-api-key"|"chatgpt"
                },
                -- env = {
                --   OPENAI_API_KEY = "my-api-key",
                -- },
              })
            end

          },
        },
        strategies = {
          chat = {
            adapter = {
              name = "copilot",
              model = "gpt-5-mini",
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
        prompt_library = {
          ["Get Linear Tickets"] = {
            strategy = "chat",
            description = "Get assigned linear tickets",
            opts = {
              mapping = "<Localleader>lt",
              --   adapter = "copilot"
              tools = {
                "linear",
                "vectorcode_query",
              },
            },

            prompts = {
              {
                role = constants.SYSTEM_ROLE,
                content = "You are an experienced developer, project manager, and product owner.",
              },
              {
                role = constants.USER_ROLE,
                content = "What linear tasks do I have that are assigned to me that need to be done?",
                opts = { auto_submit = false },
                contents = function()
                  return [[### Instructions
                  The default user you are speaking with is Bryan Lam (bryan.lam@ironsight.app) and he is on the Experience team.
                  The bulk of the tickets will be on the Experience board (experience-board-fdfec14c9ef8).


                  ### Steps to Follow
                  1. Use #{linear} to find the tickets that are assigned to the default user.]
                  2. Give a quick summmary of the linear tickets as well as the type of work that is required based off the description (if there is one).
                  3. If possible, use #{vectorcode_query} to find the possible relevant files that will need to be modified.]]
                end

              }
            },
          },
          ["Super Dev - Claude"] = {
            strategy = "chat",
            description =
            "Expert C# and Vue.js developer with migration expertise - comprehensive software engineering agent",
            opts = {
              mapping = "<Localleader>aw",
              -- adapter = {
              --   name = "copilot",
              --   model = "claude-sonnet-4",
              -- },
            },
            prompts = {
              {
                role = constants.SYSTEM_ROLE,
                content =
                [[You are an expert software engineer specializing in C# and Vue.js with a focus on producing high-quality, maintainable, scalable, and performant code.

## Core Principles:
- **Code Quality**: Write clean, readable, and well-documented code following industry best practices
- **Maintainability**: Design code that is easy to understand, modify, and extend by other developers
- **Scalability**: Create solutions that can handle growth in users, data, and complexity
- **Performance**: Optimize for speed, memory usage, and resource efficiency

## Technical Expertise:
### C# Development:
- Follow SOLID principles and clean architecture patterns
- Implement proper error handling, logging, and monitoring
- Use async/await patterns for I/O operations
- Apply appropriate design patterns (Repository, Factory, Strategy, etc.)
- Write comprehensive unit and integration tests
- Optimize database queries and use proper ORM practices
- Implement proper dependency injection and IoC containers

### Vue.js Development:
- Follow Vue 3 Composition API best practices
- Implement proper component architecture and state management
- Use TypeScript for type safety and better developer experience
- Optimize bundle size and implement code splitting
- Follow accessibility guidelines (WCAG)
- Implement proper error boundaries and loading states
- Use reactive patterns efficiently

### Vue2 to Vue3 Migration Expertise:
- Expert in migrating legacy Vue2 codebases to Vue3
- Deep knowledge of breaking changes and migration strategies
- Experience with plugin ecosystem migrations (Vuetify, Vue Router, Vuex to Pinia, etc.)
- Strategies for incremental migration and coexistence patterns
- Performance optimization during and after migration
- Automated migration tools and manual refactoring techniques
- Handling legacy component patterns and modern equivalents
- Migration of build tools and development workflows

## Development Approach:
1. **Analysis**: Thoroughly understand requirements and constraints
2. **Architecture**: Design scalable and maintainable solutions
3. **Implementation**: Write clean, tested, and documented code
4. **Validation**: Ensure code meets performance and quality standards
5. **Documentation**: Provide clear explanations and usage examples

As an autonomous AI agent, reason about the user's goal, plan necessary steps, and execute actions using available tools. Always explain your reasoning, architectural decisions, and trade-offs.]],
              },
              {
                role = constants.USER_ROLE,
                content = [[
You will have access to the following tools:
- @{linear} tool to find information on a ticket if the user mentions a linear ticket.
- @{vectorcode_query} to find project files
- @{git}
- @{memory}
- @{neovim}

**You will not respond until the user has given you a prompt.**
]]
              },
            },
          },
        },

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
              -- MCP Tools
              make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = false,          -- Show tool results directly in chat buffer
              format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = true,                     -- Convert MCP resources to #variables for prompts
              -- MCP Prompts
              make_slash_commands = true,           -- Add MCP prompts as /slash commands
            },
          },
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 0,
              -- Picker interface (auto resolved to a valid picker)
              picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
              ---Optional filter function to control which chats are shown when browsing
              chat_filter = nil, -- function(chat_data) return boolean end
              -- Customize picker keymaps (optional)
              picker_keymaps = {
                rename = { n = "r", i = "<M-r>" },
                delete = { n = "d", i = "<M-d>" },
                duplicate = { n = "<C-y>", i = "<C-y>" },
              },
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = "copilot",         -- "copilot"
                ---Model for generating titles (defaults to current chat model)
                model = "gpt-5-mini",        -- "gpt-4o"
                ---Number of user prompts after which to refresh the title (0 to disable)
                refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                ---Maximum number of times to refresh the title (default: 3)
                max_refreshes = 3,
                format_title = function(original_title)
                  -- this can be a custom function that applies some custom
                  -- formatting to the title.
                  return original_title
                end
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,

              -- Summary system
              summary = {
                -- Keymap to generate summary for current chat (default: "gcs")
                create_summary_keymap = "gcs",
                -- Keymap to browse summaries (default: "gbs")
                browse_summaries_keymap = "gbs",

                generation_opts = {
                  adapter = nil,               -- defaults to current chat adapter
                  model = nil,                 -- defaults to current chat model
                  context_size = 90000,        -- max tokens that the model supports
                  include_references = true,   -- include slash command content
                  include_tool_outputs = true, -- include tool execution results
                  system_prompt = nil,         -- custom system prompt (string or function)
                  format_summary = nil,        -- custom function to format generated summary e.g to remove <think/> tags from summary
                },
              },

              -- Memory system (requires VectorCode CLI)
              memory = {
                -- Automatically index summaries when they are generated
                auto_create_memories_on_summary_generation = true,
                -- Path to the VectorCode executable
                vectorcode_exe = "vectorcode",
                -- Tool configuration
                tool_opts = {
                  -- Default number of memories to retrieve
                  default_num = 10
                },
                -- Enable notifications for indexing progress
                notify = true,
                -- Index all existing memories on startup
                -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                index_on_startup = false,
              },
            }
          },
          -- vectorcode = {
          --   ---@type VectorCode.CodeCompanion.ExtensionOpts
          --   opts = {
          --     tool_group = {
          --       -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
          --       enabled = true,
          --       -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
          --       -- if you use @vectorcode_vectorise, it'll be very handy to include
          --       -- `file_search` here.
          --       extras = {},
          --       collapse = false, -- whether the individual tools should be shown in the chat
          --     },
          --     tool_opts = {
          --       ---@type VectorCode.CodeCompanion.ToolOpts
          --       ["*"] = {},
          --       ---@type VectorCode.CodeCompanion.LsToolOpts
          --       ls = {},
          --       ---@type VectorCode.CodeCompanion.VectoriseToolOpts
          --       vectorise = {},
          --       ---@type VectorCode.CodeCompanion.QueryToolOpts
          --       query = {
          --         max_num = { chunk = -1, document = -1 },
          --         default_num = { chunk = 50, document = 10 },
          --         include_stderr = false,
          --         use_lsp = true,
          --         no_duplicate = true,
          --         chunk_mode = true,
          --         ---@type VectorCode.CodeCompanion.SummariseOpts
          --         summarise = {
          --           ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
          --           enabled = false,
          --           adapter = nil,
          --           query_augmented = true,
          --         }
          --       },
          --       files_ls = {},
          --       files_rm = {}
          --     }
          --   },
          -- },
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
