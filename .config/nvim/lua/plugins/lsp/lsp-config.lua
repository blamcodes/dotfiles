return {

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "dockerls",
          "lua_ls",
          "ts_ls",
          "jsonls",
          -- "jdtls",
          -- "helm_ls",
          "yamlls",
          -- "phpactor",
          "eslint",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilties = capabilities,
      })

      -- lspconfig.eslint.setup({
      --     capabilties = capabilities,
      --     on_attach = function(client, bufnr)
      --         vim.api.nvim_create_autocmd("BufWritePre", {
      --             buffer = bufnr,
      --             command = "EslintFixAll",
      --         })
      --     end,
      -- })

      -- lspconfig.jedi_language_server.setup({
      -- 	capabilities = capabilities,
      -- })
      -- lspconfig.pyright.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.clangd.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.dockerls.setup({
      --   capabilities = capabilities,
      -- })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      -- lspconfig.phpactor.setup({
      --   capabilities = capabilities,
      -- })
      --
      --          lspconfig.jinja_lsp.setup({
      -- 	capabilities = capabilities,
      --          })
      --


      lspconfig.dockerls.setup {
          settings = {
              docker = {
            languageserver = {
                formatter = {
              ignoreMultilineInstructions = true,
          },
            },
        }
          }
      }

      -- lspconfig.helm_ls.setup({
      --   capabilities = capabilities,
      --   settings = {
      --     logLevel = "info",
      --     valuesFile = {
      --       mainValuesFile = "values.yaml",
      --       lintOverlayValuesFile = "values.lint.yaml",
      --       additionalValuesFileGlobPattern = "values*.yaml"
      --     },
      --     yamlls = {
      --       enabled = true,
      --       enabledForFilesGlob = "*.{yaml,yml}",
      --       diagnosticLimit = 50,
      --       showDiagnosticsDirectly = false,
      --       path = "yaml-language-server",
      --       config = {
      --         schemas = {
      --           kubernetes = "templates/**",
      --         },
      --         completion = true,
      --         hover = true,
      --       }
      --     }
      --   }
      -- })

      -- lspconfig.yamlls.setup({
      -- 	capabilities = capabilities,
      -- })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
