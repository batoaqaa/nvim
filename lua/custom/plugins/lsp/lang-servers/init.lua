local opts = require 'custom.plugins.lsp.opts'
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
  clangd = require 'custom.plugins.lsp.lang-servers.clangd',
  -- dockerls = {
  --   on_attach = opts.on_attach,
  --   capabilities = opts.capabilities,
  -- },
  gopls = require 'custom.plugins.lsp.lang-servers.gopls',
  jsonls = {
    capabilities = opts.capabilities,
  },
  lua_ls = require 'custom.plugins.lsp.lang-servers.lua_ls',
  pyright = {
    capabilities = opts.capabilities,
  },
  -- rust_analyzer = require 'custom.plugins.lsp.lang-servers.rust_analyzer',
  -- terraformls = { filetypes = { 'terraform', 'tf' } },
  -- tsserver = require 'custom.plugins.lsp.lang-servers.tsserver',
  ts_ls = require 'custom.plugins.lsp.lang-servers.tsserver',
  --  run 'npm i -g typescript'
  yamlls = require 'custom.plugins.lsp.lang-servers.yamlls',
}
