return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
              filtered_items = {
                  visible = true,
                  hide_dotfiles = false,
                  never_show = { ".git" }
              },
            },
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function ()
                        require("neo-tree.command").execute({ action = "close" })
                    end
                }
            }
        })
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

    end
}
