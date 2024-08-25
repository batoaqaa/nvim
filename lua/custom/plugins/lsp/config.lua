-- table.unpack = table.unpack or unpack
-- local lspconfig = require 'lspconfig'
-- Hook vim.lsp.client.create to add completion capabilities by default
--
-- local _create = vim.lsp.client.create
-- vim.lsp.client.create = function(config)
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   return _create(vim.tbl_deep_extend('keep', config, {
--     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
--   }))
-- end
--
local mason_lspconfig = require 'mason-lspconfig'
--
local lang_servers = require 'custom.plugins.lsp.lang-servers'
--local opts =
require 'custom.plugins.lsp.opts'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(lang_servers),
  automatic_installation = true,

  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup(lang_servers[server_name])
      -- require('lspconfig')[server_name].setup { --(lang_servers[server_name])
      --   on_attach = opts.on_attach,
      --   capabilities = opts.capabilities,
      --   -- settings = servers[server_name],
      --   -- filetypes = (servers[server_name] or {}).filetypes,
      --   settings = lang_servers[server_name],
      --   filetypes = (lang_servers[server_name] or {}).filetypes,
      -- }
    end,
    -- clangd = function(server_name)
    --   require('lspconfig')[server_name].setup(lang_servers[server_name])
    --   --   -- require('lspconfig').clangd.setup{}
    -- end,
    -- lua_ls = function(server_name)
    --   require('lspconfig')[server_name].setup(lang_servers[server_name])
    --   -- require('lspconfig').lua_ls.setup {}
    -- end,
  },
}
