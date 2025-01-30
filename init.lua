-- to disable netrw entirely
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.diagnostic.config({
  virtual_text = true,
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

------------------------
local python_version = 'python3.12'
--
local pynvim_env = vim.fn.stdpath('data') .. '/pynvim_env'
if not vim.loop.fs_stat(pynvim_env) then
  vim.fn.system({ 'python', '-m', 'venv', pynvim_env })
end

local pynvim_python, pynvim_lib
if jit.os == 'Windows' then
  pynvim_python = pynvim_env .. '/Scripts/python.exe'
  pynvim_lib = pynvim_env .. '/Lib/' .. '/site-packages/pynvim'
else
  pynvim_python = pynvim_env .. '/bin/python'
  pynvim_lib = pynvim_env .. '/lib/' .. python_version .. '/site-packages/pynvim'
end

if not vim.loop.fs_stat(pynvim_lib) then
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'pynvim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'neovim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'debugpy' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'isort' })
end

vim.g.python_host_prog = pynvim_python
vim.g.python3_host_prog = pynvim_python
------------------------
-- [[https://ibrahimshahzad.github.io/posts/writing_lsp_for_kamailio_cfg_p1/]]
require('kamailio')
------------------------
-- [[ Setting options ]]
require('options')

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
require('lazy-bootstrap')

-- [[ Configure and install plugins ]]
require('lazy-plugins')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
