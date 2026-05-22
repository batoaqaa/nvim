-- INFO: set up python nvim venv (virtual environment 'nenv'), activaten.

local isWindows = vim.fn.has('win32') == 1 --jit.os == 'Windows'
local isMac = vim.fn.has('mac') == 1
local function setup_xdg_paths()
  local home = vim.uv.os_homedir()
  local app_name = '' -- pick a temp root

  -- 1. XDG_CONFIG_HOME (Settings/Configs)
  if not vim.env.XDG_CONFIG_HOME then
    local path = isWindows and (vim.env.LOCALAPPDATA or (home .. '/AppData/Local'))
      or isMac and (home .. '/Library/Preferences')
      or (home .. '/.config')
    vim.env.XDG_CONFIG_HOME = vim.fs.joinpath(path, app_name)
  end

  -- 2. XDG_DATA_HOME (Large data/Databases)
  if not vim.env.XDG_DATA_HOME then
    local path = isWindows and (vim.env.LOCALAPPDATA or (home .. '/AppData/Local'))
      or isMac and (home .. '/Library/Application Support')
      or (home .. '/.local/share')
    vim.env.XDG_DATA_HOME = vim.fs.joinpath(path, app_name)
  end

  -- 3. XDG_STATE_HOME (Logs/History/Persistent State)
  if not vim.env.XDG_STATE_HOME then
    local path = isWindows and (vim.env.LOCALAPPDATA or (home .. '/AppData/Local'))
      or isMac and (home .. '/Library/Application Support')
      or (home .. '/.local/state')
    vim.env.XDG_STATE_HOME = vim.fs.joinpath(path, app_name)
  end

  -- 4. XDG_CACHE_HOME (Temporary/Disposable data)
  if not vim.env.XDG_CACHE_HOME then
    local path = isWindows and (vim.env.TEMP or (home .. '/AppData/Local/Temp'))
      or isMac and (home .. '/Library/Caches')
      or (home .. '/.cache')
    vim.env.XDG_CACHE_HOME = vim.fs.joinpath(path, app_name)
  end
end
setup_xdg_paths()

local pynvim_env, pynvim_python, pynvim_bin, pynvim_activate
if isWindows then
  pynvim_env = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'nenv')
  pynvim_bin = vim.fs.joinpath(pynvim_env, 'Scripts')
  pynvim_python = vim.fs.joinpath(pynvim_bin, 'python.exe')
  pynvim_activate = vim.fs.joinpath(pynvim_bin, 'Activate.ps1')
else
  pynvim_env = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'nenv')
  pynvim_bin = vim.fs.joinpath(pynvim_env, 'bin')
  pynvim_python = vim.fs.joinpath(pynvim_bin, 'python')
  pynvim_activate = vim.fs.joinpath(pynvim_bin, 'activate')
end

vim.g.python_host_prog = pynvim_python
vim.g.python3_host_prog = pynvim_python

local sep = (vim.fn.has('win32') == 1 and ';' or ':')
vim.env.PATH = pynvim_bin .. sep .. vim.env.PATH
vim.env.VIRTUAL_ENV = pynvim_env

local output
if not vim.uv.fs_stat(pynvim_env) then
  if not isWindows then
    output = vim.fn.system({ 'python3', '-m', 'venv', pynvim_env })
    print(output)
    vim.fn.system({ 'chmod', '755', '-R', pynvim_bin })
    vim.fn.system('source ' .. pynvim_activate)
  else
    vim.fn.system({ 'python', '-m', 'venv', pynvim_env })
    vim.fn.system(pynvim_activate)
  end

  --------------------------------------------------------------------------------------
  -- INFO: install platformio and nvim required packages.
  output = vim.fn.system({ pynvim_python, '-m', 'pip', 'install', '-U', 'pip' })
  print(output)
  output = vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'pynvim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'neovim' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'debugpy' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'isort' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'scons' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'sconscrip' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'yamllint' })
  vim.fn.system({ pynvim_python, '-m', 'pip', 'install', 'pyrefly' })
end
