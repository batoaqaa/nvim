local python_version = 'python3.12'
--
--:lua os.execute("setx PLATFORMIO_CORE_DIR %HOMEPATH%/.platformio")
--:lua os.execute("setx PLATFORMIO_CORE_DIR %userprofile%/.platformio")
--:lua print(os.getenv("userprofile"))
local platformio_core_dir, pynvim_env, pynvim_python, pynvim_lib, pynvim_bin, pynvim_activate
if jit.os == 'Windows' then
  platformio_core_dir = vim.env.HOME .. '\\.platformio'

  pynvim_env = platformio_core_dir .. '/nenv'
  pynvim_bin = pynvim_env .. '\\Scripts'
  pynvim_python = pynvim_bin .. '\\python.exe'
  pynvim_activate = pynvim_bin .. '\\activate'

  pynvim_lib = pynvim_env .. '\\Lib\\' .. '\\site-packages\\pynvim'
  os.execute('setx PLATFORMIO_CORE_DIR ' .. platformio_core_dir)
else
  platformio_core_dir = vim.env.HOME .. '/.platformio'

  pynvim_env = platformio_core_dir .. '/nenv'
  pynvim_bin = pynvim_env .. '/bin'
  pynvim_python = pynvim_bin .. '/python'
  pynvim_activate = pynvim_bin .. '/activate'

  pynvim_lib = pynvim_env .. '/lib/' .. python_version .. '/site-packages/pynvim'
  vim.uv.os_setenv('PLATFORMIO_CORE_DIR', platformio_core_dir)
end

if vim.fn.isdirectory(platformio_core_dir) == 0 then
  vim.fn.mkdir(platformio_core_dir, 'p')
  os.execute('wget https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py')
  os.execute('python3 get-platformio.py')
  os.execute('python3 get-platformio.py')
  if jit.os == 'Windows' then
    os.execute('del get-platformio.py*')
  else
    os.execute('rm -f get-platformio.py*')
  end
end

-- local expand_dir = vim.fn.expand(pynvim_env)
if not vim.uv.fs_stat(pynvim_env) then
  vim.fn.system({ 'python', '-m', 'venv', pynvim_env })
  if jit.os ~= 'Windows' then
    os.execute('chmod 755 -R ' .. pynvim_bin)
  end
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

-- uv.os_getenv({name} [, {size}])                                 *uv.os_getenv()*
-- uv.os_setenv({name}, {value})                                   *uv.os_setenv()*
-- uv.os_unsetenv({name})                                        *uv.os_unsetenv()*
-- uv.os_environ()                                                *uv.os_environ()*
------------------------
