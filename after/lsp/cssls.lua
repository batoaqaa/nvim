---@type vim.lsp.Config
local opts = require('custom.plugins.lsp-config.opts')
return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss' },
  root_markers = { 'package.json', '.git' },
  init_options = {
    provideFormatter = true,
  },
  capabilities = opts.capabilities,
}
