-- -- INFO: 1
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { '.git' },
})
--
-- INFO: 2 Defined in <rtp>/lsp/clangd.lua        override 1
-- INFO: 4 Defined in <rtp>/after/lsp/clangd.lua  override 1 & 2 & 3
-- suggest setting it in the after/ if you want to be sure it is setting your config and not overwritten by a default from a plugin.
local lsp_files = {}
local lsp_dir = vim.fn.stdpath('config') .. '/after/lsp/'
for _, file in ipairs(vim.fn.globpath(lsp_dir, '*.lua', false, true)) do
  -- Read the first line of the file
  local f = io.open(file, 'r')
  local first_line = f and f:read('*l') or ''
  if f then
    f:close()
  end
  -- Only include the file if it doesn't start with "-- disable"
  if not first_line:match('^%-%- disable') then
    local name = vim.fn.fnamemodify(file, ':t:r') -- `:t` gets filename, `:r` removes extension
    table.insert(lsp_files, name)
  end
end
vim.lsp.enable(lsp_files)

-- INFO: 3 Defined in custom/plugins/lsp-config/lang-servers.lua     override 1 & 2
local lang_servers = require('custom.plugins.lsp-config.lang-servers')
for srv_name, _ in pairs(lang_servers) do
  local lsp_server_settings = lang_servers[srv_name]
  -- vim.notify(opts.dump(lsp_server_settings))
  -- vim.notify(srv_name)
  vim.lsp.config(srv_name, lsp_server_settings)
end
vim.lsp.enable(vim.tbl_keys(lang_servers))
