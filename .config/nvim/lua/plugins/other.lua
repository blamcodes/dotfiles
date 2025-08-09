return {
  'rgroli/other.nvim',
  enabled = false,
  config = function()
    require("other-nvim").setup({
      -- rememberBuffers = false,
      mappings = {
        {
          pattern = "/src/IronSight.Web/Api/(.*)/(.*)/(.*)Endpoint.cs$",
          target = {
            {
              target = "/src/Tests/IronSight.Tests.FunctionalTests/PublicApi/%1/%2EndpointTests.cs",
              context = "test" -- optional
            },
            {
              target = "/src/IronSight.Application/PublicApi/Handlers/%1/%3*Handler.cs",
              context = "handler" -- optional
            },
          }
        },
        {
          pattern = "/src/IronSight.Application/PublicApi/Handlers/(.*)/(.*)CommandHandler.cs$",
          target = {
            {
              target = "/src/Tests/IronSight.Tests.IntegrationTests/PublicApi/%1/%2*HandlerTests.cs",
              context = "test" -- optional
            },
            {
              target = "/src/IronSight.Web/Api/%1/%2/%2Endpoint.cs",
              context = "controller" -- optional
            },
          }
        },
        {
          pattern = "/src/IronSight.Application/PublicApi/Handlers/(.*)/(.*)QueryHandler.cs$",
          target = {
            {
              target = "/src/Tests/IronSight.Tests.IntegrationTests/PublicApi/%1/%2*HandlerTests.cs",
              context = "test" -- optional
            },
            {
              target = "/src/IronSight.Web/Api/%1/%2/%2Endpoint.cs",
              context = "controller" -- optional
            },
          }
        },
        {
          pattern = "/src/Tests/IronSight.Tests.FunctionalTests/PublicApi/(.*)/(.*)EndpointTests.cs",
          target = {
            {
              target = "/src/IronSight.Web/Api/%1/%2Endpoint.cs",
              context = "controller" -- optional
            },
          }
        },
        {
          pattern = "/src/Tests/IronSight.Tests.IntegrationTests/PublicApi/(.*)/(.*)QueryHandlerTests.cs",
          target = {
            {
              target = "/src/IronSight.Application/PublicApi/Handlers/%1/%2*Handler.cs",
              context = "handler" -- optional
            },
          }
        },
        {
          pattern = "/src/Tests/IronSight.Tests.IntegrationTests/PublicApi/(.*)/(.*)CommandHandlerTests.cs",
          target = {
            {
              target = "/src/IronSight.Application/PublicApi/Handlers/%1/%2*Handler.cs",
              context = "handler" -- optional
            },
          }
        },
        -- {
        --   pattern = "/src/Tests/IronSight.Tests.FunctionalTests/PublicApi/(.*)/(.*)Tests.cs$",
        --   target = "/src/IronSight.Web/Api/%1/%2.cs",
        --   context = "test" -- optional
        -- },

      }

    })


    vim.api.nvim_set_keymap("n", "<leader>ol", "<cmd>:Other<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>otn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>op", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>ov", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>oc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })

    -- Context specific bindings
    vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>:Other test<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>oc", "<cmd>:Other controller<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>oh", "<cmd>:Other handler<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>os", "<cmd>:Other scss<CR>", { noremap = true, silent = true })

    -- Check https://github.com/rgroli/other.nvim
  end
}
