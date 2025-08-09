return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        enabled = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {},
        config = function()
            local fzf = require("fzf-lua")

            fzf.setup({ "fzf-native" })

            vim.keymap.set('n', '<leader>p', fzf.files, {})
            -- vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fg', fzf.live_grep, {})
            vim.keymap.set('n', '<leader>fc', fzf.lgrep_curbuf, {})
            -- vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
            vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
            vim.keymap.set('n', '<leader>fq', ":TodoFzfLua<CR>", {})
            -- vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
            -- vim.keymap.set('n', '<leader>fd', function()
            --     builtin.lsp_document_symbols({
            --         symbols = { 'function', 'method', 'variable' }
            --     })
            -- end, {})
            -- vim.keymap.set('n', '<leader>fw', function()
            --     builtin.lsp_workspace_symbols({
            --         symbols = { 'function', 'class' }
            --     })
            -- end, {})
        end
    }
}
