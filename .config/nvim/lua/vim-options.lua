-- Neovim Base
vim.opt.termguicolors = true
-- vim.opt.signcolumn = 'yes'

-- Leader Key
vim.g.mapleader = " "

-- File Lines
vim.wo.relativenumber = true
vim.opt.wrap = false

-- INDENT Settings
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2

-- TAB Settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- SEARCH Settings
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wildignore:append { '*/node_modules/*', '*/vendor/*' }

-- CONTEXTUAL Settings
vim.opt.title = true
vim.opt.path:append { '**' }

-- COPY/PASTING Settings
vim.cmd("set clipboard+=unnamedplus")


vim.cmd("set number")
vim.cmd("set cursorline")
