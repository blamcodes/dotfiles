return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
            require("telescope").load_extension('harpoon')
            local opts = {}
			vim.keymap.set("n", "<leader>hm", ':lua require("harpoon.mark").add_file()<CR>', opts)
			vim.keymap.set("n", "<leader>hp", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
			vim.keymap.set("n", "<leader>hh", ':lua require("harpoon.ui").nav_next()<CR>', opts)
			vim.keymap.set("n", "<leader>hl", ':lua require("harpoon.ui").nav_prev()<CR>', opts)
		end,
	},
}
