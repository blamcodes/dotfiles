return {
    'stevearc/overseer.nvim',
    -- lazy = true,
    opts = {},
    config = function()
        -- TODO: Add session support so that tasks are saved when in a session.
        require('overseer').setup()

        vim.api.nvim_set_keymap('n', '<leader>ot', ':OverseerToggle right<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>ob', ':OverseerLoadBundle<CR>', { noremap = true, silent = true })
    end
}
