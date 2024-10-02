return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'dapc11/telescope-yaml.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      }
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
          }
        }
      })

      telescope.load_extension('fzf')

      local builtin = require("telescope.builtin")

      vim.keymap.set('n', '<leader>p', builtin.find_files, {})
      vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fd', function()
        builtin.lsp_document_symbols({
          symbols = { 'function' }
        })
      end, {})
      vim.keymap.set('n', '<leader>fw', function()
        builtin.lsp_workspace_symbols({
          symbols = { 'function', 'class' }
        })
      end, {})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
  {
    {
      "cuducos/yaml.nvim",
      ft = { "yaml" }, -- optional
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
      },
      config = function()
        require("lualine").setup({
          sections = {
            lualine_x = {

              require("yaml_nvim").get_yaml_key_and_value
            },
          }
        })
      end
    }
  }
}
