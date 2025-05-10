local python_version = 'python3.13'
--
--global environment variable PLATFORMIO_CORE_DIR
--    Unix ~/.platformio
--    Windows %HOMEPATH%\.platformio

--:lua os.execute("setx PLATFORMIO_CORE_DIR %HOMEPATH%/.platformio")
--:lua os.execute("setx PLATFORMIO_CORE_DIR %userprofile%/.platformio")
--:lua print(os.getenv("userprofile"))
local platformio_core_dir, pynvim_env, pynvim_python, pynvim_lib, pynvim_bin, pynvim_activate
if jit.os == 'Windows' then
  platformio_core_dir = os.getenv('userprofile') .. '\\.platformio'

  pynvim_env = platformio_core_dir .. '/penv'
  pynvim_bin = pynvim_env .. '\\Scripts'
  pynvim_python = pynvim_bin .. '\\python.exe'
  pynvim_activate = pynvim_bin .. '\\activate'

  pynvim_lib = pynvim_env .. '\\Lib\\' .. '\\site-packages\\pynvim'
else
  platformio_core_dir = '~/.platformio'

  pynvim_env = platformio_core_dir .. '/penv'
  pynvim_bin = pynvim_env .. '/bin'
  pynvim_python = pynvim_bin .. '/python'
  pynvim_activate = 'source' .. pynvim_bin .. '/activate'

  pynvim_lib = pynvim_env .. '/lib/' .. python_version .. '/site-packages/pynvim'
end

if vim.fn.isdirectory(platformio_core_dir) == 0 then
  os.execute('mkdir ' .. platformio_core_dir)
end
os.execute('setx PLATFORMIO_CORE_DIR ' .. platformio_core_dir)

if not vim.uv.fs_stat(pynvim_env) then
  vim.fn.system({ 'python', '-m', 'venv', pynvim_env })
end

if not vim.uv.fs_stat(pynvim_lib) then
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

vim.fn.system({ pynvim_activate })
------------------------
