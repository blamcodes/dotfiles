return {
    --- Auto bracket closing
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function ()
            require("nvim-autopairs").setup({})
        end
    },
	{
		"gelguy/wilder.nvim",
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "/", "?" } })
			wilder.set_option(
				"renderer",
				wilder.renderer_mux({
					[":"] = wilder.popupmenu_renderer({
						highlighter = wilder.basic_highlighter(),
					}),
					["/"] = wilder.popupmenu_renderer({
						highlighter = wilder.basic_highlighter(),
					}),
				})
			)
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				-- Window Appearance
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Keybinds
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_next_item()
                      else
                        fallback()
                      end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_prev_item()
                      else
                        fallback()
                      end
                    end, { 'i', 's' }),
                    }),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
                    { name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
