return {
    "echasnovski/mini.files",
    -- enabled = false,
    version = false,
    dependencies = {
        "echasnovski/mini.icons", version = false
    },
    config = function()
        require("mini.files").setup()
        vim.keymap.set('n', '-', ':lua MiniFiles.open()<CR>', {})
    end
}
