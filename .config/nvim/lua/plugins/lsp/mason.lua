return {
	{
		"williamboman/mason.nvim",
		config = function()
            local mason = require("mason")

            mason.setup({
                ui = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            })
		end,
	},
}
