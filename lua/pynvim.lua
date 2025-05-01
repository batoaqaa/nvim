------------------------
local python_version = 'python3.13'
--
local pynvim_env = vim.fn.stdpath('data') .. '/pynvim_env'

local pynvim_python, pynvim_lib, pynvim_bin, pynvim_activate
if jit.os == 'Windows' then
  pynvim_bin = pynvim_env .. '/Scripts'
  pynvim_python = pynvim_bin .. '/python.exe'
  pynvim_activate = pynvim_bin .. '/activate'

  pynvim_lib = pynvim_env .. '/Lib/' .. '/site-packages/pynvim'
else
  pynvim_bin = pynvim_env .. '/bin'
  pynvim_python = pynvim_bin .. '/python'
  pynvim_activate = 'source' .. pynvim_bin .. '/activate'

  pynvim_lib = pynvim_env .. '/lib/' .. python_version .. '/site-packages/pynvim'
end

if not vim.loop.fs_stat(pynvim_env) then
  vim.fn.system({ 'python', '-m', 'venv', pynvim_env })
end
vim.fn.system({ pynvim_activate })

if not vim.loop.fs_stat(pynvim_lib) then
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'pynvim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'neovim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'debugpy' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'isort' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'scons' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'yamllint' })
end

vim.g.python_host_prog = pynvim_python
vim.g.python3_host_prog = pynvim_python
vim.env.VIRTUAL_ENV = pynvim_env
------------------------
