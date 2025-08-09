return
{
    "danymat/neogen",
    config = function()
        require('neogen').setup {
            enabled = true,
            languages = {
                cs = {
                    template = {
                        annotation_convention = "xmldoc"
                    }
                },
            }
        }

        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<Leader>Nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
        vim.api.nvim_set_keymap("n", "<Leader>Nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
    end
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
