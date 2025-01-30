local M = {}

-- Define default configuration settings
M.config = {
  KamailioSourcePath = vim.fn.getcwd(),
  loglevel = 3,
}

-- Function to setup the configuration with user overrides
function M.setup(user_config)
  if user_config then
    for key, value in pairs(user_config) do
      M.config[key] = value
    end
  end
end

return M
