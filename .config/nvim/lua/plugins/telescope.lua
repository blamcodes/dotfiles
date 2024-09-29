return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim', 'dapc11/telescope-yaml.nvim' },
        config = function()
            vim.g.telescope = 'rg'
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>p', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fs', function()
                builtin.lsp_document_symbols({
                    ignore_symbols = { 'variables' }
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
