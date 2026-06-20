---@type vim.lsp.Config
return {
  -- lazy-load schemastore when needed
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = { provideFormatter = true },
  root_makers = { '.git' },
}
-- return {
--   cmd = { 'vscode-json-language-server', '--stdio' },
--   filetypes = { 'json', 'jsonc' },
--   dependencies = {
--     'b0o/schemastore.nvim',
--   },
--   init_options = {
--     provideFormatter = true,
--   },
--   root_markers = { '.git' },
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--       validate = { enable = true },
--       format = { enable = true },
--     },
--     schemas = {
--       ['https://raw.githubusercontent.com/xaaha/hulak/refs/heads/main/assets/schema.json'] = {
--         '**/*.hk.yaml',
--         '**/*.hk.yml',
--         '**/*.hk.json',
--       },
--     },
--   },
-- }
