-- Neovim Base
vim.opt.termguicolors = true
-- vim.opt.signcolumn = 'yes'

-- Leader Key
vim.g.mapleader = " "

-- File Lines
vim.wo.relativenumber = true
vim.opt.wrap = true

-- INDENT Settings
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2

-- Editor Config
vim.g.editorconfig = true

-- TAB Settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Folding
vim.opt.foldenable = false

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
-- Highlight the current line
vim.cmd("set cursorline")

-- Remove the ~ chars for empty lines.
-- @see https://tinyurl.com/mvx5u4jy
vim.opt.fillchars = { eob = ' ' }

-- vim.diagnostic.config({
--   virtual_text = false
-- })

-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 500
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
