return {
    --[[
	"plasticboy/vim-markdown",
	branch = "master",
	require = { "godlygeek/tabular" },
	config = function()
        vim.g.tex_conceal = "admgs"
		vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_folding_disabled = 1
        vim.opt.conceallevel = 2
	end,
    --]]
}
