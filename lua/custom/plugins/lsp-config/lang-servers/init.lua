local opts = require('custom.plugins.lsp-config.opts')
return {
  biome = {
    capabilities = opts.capabilities,
  },
  cssls = {
    capabilities = opts.capabilities,
  },
  html = {
    capabilities = opts.capabilities,
  },
  clangd = require('custom.plugins.lsp-config.lang-servers.clangd'),
  -- dockerls = {
  --   on_attach = opts.on_attach,
  --   capabilities = opts.capabilities,
  -- },
  bashls = require('custom.plugins.lsp-config.lang-servers.bashls'),
  gopls = require('custom.plugins.lsp-config.lang-servers.gopls'),
  jsonls = {
    capabilities = opts.capabilities,
  },
  lua_ls = require('custom.plugins.lsp-config.lang-servers.lua_ls'),
  pyright = {
    capabilities = opts.capabilities,
  },
  -- rust_analyzer = require 'custom.plugins.lsp-config.lang-servers.rust_analyzer',
  -- terraformls = { filetypes = { 'terraform', 'tf' } },
  -- tsserver = require 'custom.plugins.lsp-config.lang-servers.tsserver',
  ts_ls = require('custom.plugins.lsp-config.lang-servers.tsserver'),
  --  run 'npm i -g typescript'
  --  or run 'npm install --global typescript'
  yamlls = require('custom.plugins.lsp-config.lang-servers.yamlls'),
}
