return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "github/copilot.vim",
                enabled = false,
                config = function()
                    vim.g.copilot_workspace_folders = { vim.fn.expand("~/apps/IronSight-Web") }
                end
            }
        },
        opts = {
            strategies = {
                chat = {
                    slash_commands = {
                        ["buffer"] = {
                            opts = {
                                provider = "fzf_lua"
                            }
                        }
                    }
                }
            }
        },
        config = function()
            require("codecompanion").setup({
                opts = {
                    system_prompt = function(opts)
                        return [[You are an AI programming assistant named "CodeCompanion". You are currently plugged in to the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- When showing code, you will only show the modified updated parts that you are referring to. 
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must be in %s.


When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block, being careful to only return relevant code.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
]]
                    end,

                },
                strategies = {
                    chat = {
                        slash_commands = {
                            ["buffer"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                            ["file"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                        }
                    }
                },
                prompt_library = {
                    ["Public API Expert (Reverted State)"] = {
                        strategy = "chat",
                        description = "Get advice and assistance on API Deveploment",
                        opts = {
                            mapping = "<leader>Ai",
                            is_default = true,
                            auto_submit = true,
                            short_name = "api-tests",
                            is_slash_command = true,
                        },
                        references = {
                            {
                                type = "file",
                                path = {
                                    "src/Tests/FunctionalTests/PublicApi/CostCenters/CreateCostCenterForHubEndpointTests.cs",
                                    "src/Tests/FunctionalTests/PublicApi/CostCenters/UpdateCostCenterForHubEndpointTests.cs",
                                    "src/Tests/FunctionalTests/PublicApi/CostCenters/GetCostCentersForHubEndpointTests.cs",
                                    "src/Tests/FunctionalTests/PublicApi/CostCenters/GetCostCenterByIdForHubEndpointTests.cs",
                                    "src/Tests/FunctionalTests/PublicApi/CostCenters/DeleteCostCenterForHubEndpointTests.cs",
                                }
                            },
                            {
                                type = "file",
                                path = {
                                    "src/Tests/IntegrationTests/PublicApi/CostCenters/CreateCostCenterForHubCommandHandlerTests.cs",
                                    "src/Tests/IntegrationTests/PublicApi/CostCenters/UpdateCostCenterForHubCommandHandlerTests.cs",
                                    "src/Tests/IntegrationTests/PublicApi/CostCenters/GetCostCentersForHubQueryHandlerTests.cs",
                                    "src/Tests/IntegrationTests/PublicApi/CostCenters/GetCostCenterForHubQueryHandlerTests.cs",
                                    "src/Tests/IntegrationTests/PublicApi/CostCenters/DeleteCostCenterForHubCommandHandlerTests.cs",
                                }
                            },
                            {
                                type = "file",
                                path = {
                                    "src/IronSight.Web/Api/CostCenters/CreateCostCenterForHub/CreateCostCenterForHubEndpoint.cs",
                                    "src/IronSight.Web/Api/CostCenters/UpdateCostCenterForHub/UpdateCostCenterForHubEndpoint.cs",
                                    "src/IronSight.Web/Api/CostCenters/GetCostCentersForHub/GetCostCentersForHubEndpoint.cs",
                                    "src/IronSight.Web/Api/CostCenters/GetCostCentersForHub/GetCostCentersForHubRequest.cs",
                                    "src/IronSight.Web/Api/CostCenters/GetCostCenterByIdForHub/GetCostCenterByIdForHubEndpoint.cs",
                                    "src/IronSight.Web/Api/CostCenters/GetCostCenterByIdForHub/GetCostCenterByIdForHubEndpoint.cs",
                                    "src/IronSight.Web/Api/CostCenters/DeleteCostCenterForHub/DeleteCostCenterForHubEndpoint.cs",
                                }
                            },
                            {
                                type = "file",
                                path = {
                                    "src/IronSight.Application/PublicApi/Handlers/CreateCostCenterForHubCommandHandler.cs",
                                    "src/IronSight.Application/PublicApi/Handlers/UpdateCostCenterForHubHandler.cs",
                                    "src/IronSight.Application/PublicApi/Handlers/GetCostCentersByHubQueryHandler.cs",
                                    "src/IronSight.Application/PublicApi/Handlers/GetCostCenterForHubQueryHandler.cs",
                                    "src/IronSight.Application/PublicApi/Handlers/DeleteCostCenterForHubCommandHandler.cs",
                                }
                            }
                        },
                        prompts = {
                            {
                                -- TODO: Change this to system?
                                role = "user",
                                -- content = "You are a Senior Developer and expert in API Development in .NET and C# @full_stack_dev and will be assisting me with generating functional and integration tests."
                                content = "You want you to act as a Senior Developer and expert in API Development in .NET and C# with permission to make changes to files (@files) and will be assisting me with generating functional tests."
                            },
                            {
                                role = "user",
                                content = "You will only respond with XML required to perform the actions you need to make, no explanations.",
                            },
                            {
                                role = "user",
                                content = [[

You understand that:
- Files that are under "src/IronSight.Web/Api" are the controller files which you will use as a reference for controllers.
- Files that are under "src/Tests/FunctionalTests/Api" are the functional tests files which you will use as a reference for functional tests.
- Files that are under "src/Tests/IntegrationTests/Api" are the integration tests files which you will use as a reference for integration tests.

You will follow the following guidelines for the API are as follows:
- If the endpoint is a GET endpoint that returns multiple items, it must support pagination.
    - If the endpoint has a request object, like GetDivisionsForHubRequest, you will update that file as well.
    - Use the given controller files as reference. Pay close attention to the constructors and how arguments are being passed.
- If the endpoint is nested under a hub, like /api/hubs/{HubId}/divisions, you will add a Sluglook up service and pass the HubId to the query.
    - In the handler, there will be an access check using the HubId which is a Guid.

When you are given a file(s), you WILL perform multiple actions: 
1. YOU WILL CREATE the tests FOR this file. This is your main priority!
2. UPDATE the file IF it does not follow the guidelines.

**When UPDATING a file, you will use the CREATE `<action type="create">` action to replace the entire file, NOT the EDIT `<action type="edit">` action.**

While updating you make note of the following:
- When you see a variable that is based off `IApplicationDbContext`, the variable name should be `dbContext`.
                                ]],
                            },
                            {
                                role = "user",
                                content = [[
You will examine the file that I give you and you will check to see if it matches the convention and format of the reference files. 
- If the file does not match the conventions, such as it is missing pagination, you will update this file.]],
                            },
                            {
                                role = "user",
                                content = [[
Your main priority will be creating functional and integration tests. If the file I provided you does not follow the same conventions or the guidelines above, such as does not have pagination, you will update the file too.
You will be able to perform multiple actions. For example, you will create a test for the file and if that file does not match the conventions in the reference files, you will update the provide file as well.]]
                            },
                            {
                                role = "user",
                                content = "You will wait for my input."
                            },
                        },
                    },
                    ["Test Renamer"] = {
                        strategy = "chat",
                        description = "Get some special advice from an LLM",
                        opts = {
                            mapping = "<LocalLeader>tr",
                            modes = { "v" },
                            short_name = "test-rename",
                            auto_submit = true,
                            stop_context_insertion = true,
                            user_prompt = true,
                        },
                        prompts = {
                            {
                                role = "system",
                                content = function(context)
                                    return "I want you to act as a senior "
                                        .. context.filetype
                                        .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
                                end,
                            },
                            {
                                role = "user",
                                content = function(context)
                                    local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                        context.end_line)

                                    return "I have the following code:\n\n```" ..
                                        context.filetype .. "\n" .. text .. "\n```\n\n"
                                end,
                                opts = {
                                    contains_code = true,
                                }
                            },
                        },

                    },
                    ["Code Expert"] = {
                        strategy = "chat",
                        description = "Get some special advice from an LLM",
                        opts = {
                            mapping = "<leader>ce",
                            modes = { "v" },
                            short_name = "expert",
                            auto_submit = true,
                            stop_context_insertion = true,
                            user_prompt = true,
                        },
                        prompts = {
                            {
                                role = "system",
                                content = function(context)
                                    return "I want you to act as a senior "
                                        .. context.filetype
                                        .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
                                end,
                            },
                            {
                                role = "user",
                                content = function(context)
                                    local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                        context.end_line)

                                    return "I have the following code:\n\n```" ..
                                        context.filetype .. "\n" .. text .. "\n```\n\n"
                                end,
                                opts = {
                                    contains_code = true,
                                }
                            },
                        },
                    },
                },
            })

            -- Keymaps
            vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("v", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.cmd([[cab cc CodeCompanion]])
        end
    }
}
