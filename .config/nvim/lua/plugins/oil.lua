return {
    "stevearc/oil.nvim",
    enabled = false,
    config = function()
        require("oil").setup()

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
