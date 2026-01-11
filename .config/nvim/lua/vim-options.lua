-- For Rosyln
vim.env.DOTNET_GCHeapHardLimit = 4294967296
vim.env.DOTNET_GCHeapHardLimitPercent = 50
vim.opt.showmode = false

-- Neovim Base
vim.opt.termguicolors = true
vim.o.conceallevel = 1

-- Leader Key
vim.g.mapleader = " "

-- File Lines
vim.wo.relativenumber = true
vim.opt.wrap = false

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

vim.keymap.set('n', '<leader>q', ":q<CR>", { desc = "Quit" })
vim.keymap.set('n', '<leader>w', ":w<CR>", { desc = "Write Changes" })
vim.keymap.set('n', '<leader>bd', ":bdelete<CR>", { desc = "Delete Buffer" })
-- Delete all buffers (%bd) and open last buffer for editing (e#)
vim.keymap.set('n', '<leader>bA', ":%bd|e#<CR>", { desc = "Delete All Buffers and Open Last Buffer For Editing" })

-- Terminal mode keybinds
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

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

local pattern = '%[(.+)%] (.+): (.+)'
local severity_map = {
  ['ERROR'] = vim.diagnostic.severity.ERROR,
  ['WARNING'] = vim.diagnostic.severity.WARN,
  ['INFO'] = vim.diagnostic.severity.INFO,
}

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
})


-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support

-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 800

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Global Keybinds
vim.keymap.set({ 'n', 'v' }, '<Leader>dh',
  function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      width = 80,
      source = "if_many",
      scope = "line",
      border =
      "single"
    })
  end, { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>FzfLua diagnostics_workspace<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

vim.g.rbql_backend_language = 'js'
