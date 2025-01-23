return {
    "roobert/action-hints.nvim",
    enabled = false,
    config = function()
        require("action-hints").setup({
            template = {
                definition = { text = " ⊛", color = "#add8e6" },
                references = { text = " ↱%s", color = "#ff6666" },
            },
            use_virtual_text = true,
        })
    end,
}
