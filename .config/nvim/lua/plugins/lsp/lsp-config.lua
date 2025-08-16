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
          "vtsls"
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
      local vue_language_server_path = "/usr/lib/node_modules/@vue/language-server"
      -- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. 'vue-language-server'
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }

      vim.lsp.config('vtsls', {
        settings = {
          vtsls = {
            enableEslint = true,
            eslint = {
              enabled = true,
              run = "onSave",
            },
            -- autoUseWorkspaceTsdk = true,
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },

        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- vim.lsp.config('vue_ls', {})
      --
      -- vim.lsp.enable('vue_ls')
      vim.lsp.enable('vtsls')

      -- lspconfig.postgrestools.setup({
      --   capabilties = capabilities,
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
      vim.keymap.set({ "n", "v" }, "<leader>ca",
        function() vim.lsp.buf.code_action({ context = { only = { "source" } } }) end, {})
      vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set(
        "n",
        "<leader>co",
        function()
          vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        end,
        { desc = "Organize imports" }
      )
      vim.keymap.set(
        "n",
        "<leader>cM",
        function()
          vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports.ts" } }, apply = true })
        end,
        { desc = "Add missing imports" }
      )
      vim.keymap.set(
        "n",
        "<leader>cu",
        function()
          vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports.ts" } }, apply = true })
        end,
        { desc = "Remove unused imports" }
      )
    end,
  },
}
