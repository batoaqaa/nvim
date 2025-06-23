local isWindows = jit.os == "Windows"
--
local platformio_core_dir, pynvim_env, pynvim_python, pynvim_lib, pynvim_bin, pynvim_activate
if isWindows then
  platformio_core_dir = vim.env.HOME .. "\\.platformio"
  pynvim_env = platformio_core_dir .. "\\nenv"
  pynvim_bin = pynvim_env .. "\\Scripts"
  pynvim_python = pynvim_bin .. "\\python.exe"
  pynvim_activate = pynvim_bin .. "\\activate"
else
  platformio_core_dir = vim.env.HOME .. "/.platformio"
  pynvim_env = platformio_core_dir .. "/nenv"
  pynvim_bin = pynvim_env .. "/bin"
  pynvim_python = pynvim_bin .. "/python"
  pynvim_activate = pynvim_bin .. "/activate"
end

vim.uv.os_setenv("PLATFORMIO_CORE_DIR", platformio_core_dir)
vim.g.python_host_prog = pynvim_python
vim.g.python3_host_prog = pynvim_python
vim.env.PATH = pynvim_bin .. (isWindows and ";" or ":") .. vim.env.PATH
vim.env.VIRTUAL_ENV = pynvim_env

if vim.fn.isdirectory(platformio_core_dir) == 0 then
  vim.fn.mkdir(platformio_core_dir, "p")
  vim.fn.system({
    "wget",
    "https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py",
  })
  vim.fn.system({ "python", "get-platformio.py" })
  os.execute((isWindows and "del " or "rm -f ") .. "get-platformio.py*")
end

-- local expand_dir = vim.fn.expand(pynvim_env)
if not vim.uv.fs_stat(pynvim_env) then
  vim.fn.system({ "python", "-m", "venv", pynvim_env })
  if not isWindows then
    os.execute("chmod 755 -R " .. pynvim_bin)
  end

  vim.fn.system({ pynvim_python, "-m", "pip", "install", "pynvim" })
  vim.fn.system({ pynvim_python, "-m", "pip", "install", "neovim" })
  vim.fn.system({ pynvim_python, "-m", "pip", "install", "debugpy" })
  vim.fn.system({ pynvim_python, "-m", "pip", "install", "isort" })
  vim.fn.system({ pynvim_python, "-m", "pip", "install", "scons" })
  vim.fn.system({ pynvim_python, "-m", "pip", "install", "yamllint" })
end
------------------------
