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
