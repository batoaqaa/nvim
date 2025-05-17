local opts = require('custom.plugins.lsp-config.opts')
return {
  arduino_language_server = {
    capabilities = opts.capabilities,
  },
  -- bashls = require('custom.plugins.lsp-config.lang-servers.bashls'),
  biome = {
    capabilities = opts.capabilities,
  },
  -- clangd = require('custom.plugins.lsp-config.lang-servers.clangd'),
  -- dockerls = {
  --   on_attach = opts.on_attach,
  --   capabilities = opts.capabilities,
  -- },
  -- gopls = require('custom.plugins.lsp-config.lang-servers.gopls'),
  -- lua_ls = require('custom.plugins.lsp-config.lang-servers.lua_ls'),
  -- pyright = {
  --   capabilities = opts.capabilities,
  --   before_init = function(_, config)
  --     config.settings.python.pythonPath = vim.g.python_host_prog
  --     config.settings.python.analysis = {
  --       autoSearchPaths = true,
  --       useLibraryCodeForTypes = true,
  --       diagnosticMode = 'workspace',
  --     }
  --   end,
  -- },
  -- rust_analyzer = require 'custom.plugins.lsp-config.lang-servers.rust_analyzer',
  -- terraformls = { filetypes = { 'terraform', 'tf' } },
  -- tsserver = require 'custom.plugins.lsp-config.lang-servers.tsserver',
  -- ts_ls = require('custom.plugins.lsp-config.lang-servers.tsserver'),
  --  run 'npm i -g typescript'
  --  or run 'npm install --global typescript'
  -- yamlls = require('custom.plugins.lsp-config.lang-servers.yamlls'),
}
-- local opts = require('custom.plugins.lsp-config.opts')
-- return {
--   arduino_language_server = require('lspfiles.arduino_language_server'),
--   bashls = require('lspfiles.bashls'),
--   biome = require('lspfiles.biome'),
--   clangd = require('lspfiles.clangd'),
--   cssls = require('lspfiles.cssls'),
--   gopls = require('lspfiles.gopls'),
--   html = require('lspfiles.html'),
--   -- dockerls = {
--   --   on_attach = opts.on_attach,
--   --   capabilities = opts.capabilities,
--   -- },
--   jsonls = require('lspfiles.jsonls'),
--   lua_ls = require('lspfiles.lua_ls'),
--   pyright = require('lspfiles.pyright'),
--   rust_analyzer = require('lspfiles.rust_analyzer'),
--   terraformls = require('lspfiles.terraformls'),
--   tsserver = require('lspfiles.tsserver'),
--   ts_ls = require('lspfiles.ts_ls'),
--   --  run 'npm i -g typescript'
--   --  or run 'npm install --global typescript'
--   yamlls = require('lspfiles.yamlls'),
-- }
