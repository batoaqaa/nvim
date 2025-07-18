-- to disable netrw entirely
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Toggle virtual_text off when on the line with the error
vim.diagnostic.config({
  -- virtual_text = true,
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = '●',
  --   current_line = true,
  -- },
  virtual_lines = true,
  -- virtual_lines = { current_line = true },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
})

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require('config.options')

-- [[ Basic Keymaps ]]
require('config.keymaps')

-- [[ Configure python env ]]
require('config.pynvim')

-- [[ Install `lazy.nvim` plugin manager ]]
require('config.lazyboot')
require('config.lazysetup')
require('config.autocmds')

------------------------
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
