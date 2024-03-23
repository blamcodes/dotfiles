return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-jdtls",
            "nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()
			require("dap").adapters.go.executable.detached = false

			-- Dapui
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Keybinds
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
			vim.keymap.set("n", "<Leader>do", dap.step_over, {})
		end,
	},
}
