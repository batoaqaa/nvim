-- diable
---@type vim.lsp.Config
local opts = require('custom.plugins.lsp-config.opts')
return {
  biome = {
    capabilities = opts.capabilities,
  },
}
