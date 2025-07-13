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

-- vim.api.nvim_create_autocmd('ModeChanged', {
--   pattern = { '*:i*', 'i*:*' },
--   group = vim.api.nvim_create_augroup('EnableDisableRelativenumber', {clear = true}),
--   callback = function()
--     vim.o.relativenumber = vim.api.nvim_get_mode().mode:match('^i') == nil
--   end,
-- })
------------------------
vim.api.nvim_create_autocmd({
  'BufEnter',
  'FocusGained',
  'InsertLeave',
  'CmdlineLeave',
  'WinEnter',
}, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('EnableRelativenumber', { clear = true }),
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
  desc = 'Enable relative number in normal mode',
})

vim.api.nvim_create_autocmd({
  'BufLeave',
  'FocusLost',
  'InsertEnter',
  'CmdlineEnter',
  'WinLeave',
}, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('DisableRelativenumber', { clear = true }),
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd('redraw')
    end
  end,
  desc = 'Disable relative number in insert mode',
})
-- In your init.lua or a loaded config file

-- vim.g.enable_toggle_me_plugin = true -- Default to enabled, or false if you want it off by default

vim.api.nvim_create_user_command('ReloadPlugin', function()
  -- vim.g.enable_toggle_me_plugin = not vim.g.enable_toggle_me_plugin
  print("Toggling 'toggle-me-plugin' to: " .. (vim.g.enable_toggle_me_plugin and 'enabled' or 'disabled'))

  -- Crucially, reload lazy.nvim to apply the change
  require('lazy').reload()

  -- You might want to also re-source your init.lua if the global variable
  -- is set there, to ensure it's picked up before the Lazy reload.
  -- :source $MYVIMCONFIG/init.lua
end, {
  desc = 'Toggle the "toggle-me-plugin" on/off and reload lazy.nvim',
})
------------------------
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
