return {
	{
		"williamboman/mason.nvim",
		config = function()
            local mason = require("mason")

            mason.setup({
                registries = {
                  'github:mason-org/mason-registry',
                  'github:crashdummyy/mason-registry',
                },
                ui = {

                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            })
		end,
	},
}
