---@type vim.lsp.Config
return {
  name = 'pyrefly',
  cmd = { 'pyrefly', 'lsp' },
  filetypes = { 'python' },
  root_markers = { 'pyrefly.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
  settings = {
    python = {
      pythonPath = vim.env.VIRTUAL_ENV,
      -- venvPath = vim.env.VIRTUAL_ENV,
    },
  },
}
