return {

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- "dockerls",
          -- "lua_ls",
          -- "ts_ls",
          -- "vue_ls",
          -- "jsonls",
          -- "jdtls",
          -- "helm_ls",
          -- "yamlls",
          -- "phpactor",
          -- "eslint",
          -- "postgrestools"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- local lspconfig = require("lspconfig")

      local vue_language_server_path = "/usr/lib/node_modules/@vue/language-server"
      local ts_ls_config = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }

      -- No need to set `hybridMode` to `true` as it's the default value
      local vue_ls_config = {}

      vim.lsp.config("ts_ls", ts_ls_config)
      vim.lsp.config("vue_ls", vue_ls_config)
      vim.lsp.enable({"ts_ls", "vue_ls_config"})
      --
      -- lspconfig.postgrestools.setup({
      --   capabilties = capabilities,
      -- })

      local eslint_config = {
        settings = {
          experimental = {
            useFlatConfig = false
          }
        }
      }
      vim.lsp.config("eslint", eslint_config)
      vim.lsp.enable({"eslint", "eslint_config"})
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

      -- lspconfig.jsonls.setup({
      --   capabilities = capabilities,
      -- })

      -- lspconfig.phpactor.setup({
      --   capabilities = capabilities,
      -- })
      --
      --          lspconfig.jinja_lsp.setup({
      -- 	capabilities = capabilities,
      --          })
      --

      --
      -- lspconfig.dockerls.setup {
      --   settings = {
      --     docker = {
      --       languageserver = {
      --         formatter = {
      --           ignoreMultilineInstructions = true,
      --         },
      --       },
      --     }
      --   }
      -- }

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
      --
      --
      -- vim.lsp.enable('dartls')

      vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}
