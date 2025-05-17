-- diaable
---@type vim.lsp.Config
local opts = require('custom.plugins.lsp-config.opts')
return {
  arduino_language_server = {
    capabilities = opts.capabilities,
  },
}
