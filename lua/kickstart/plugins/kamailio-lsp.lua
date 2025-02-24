-- return {
--   'batoaqaa/kamailio-lsp',
--   -- 'batoaqaa/kamaizen.nvim',
--   dependencies = {
--     { 'IbrahimShahzad/KamaiZen', build = 'go build' },
--   },
--   -- lazy = true,
--   opts = {
--     settings = {
--       kamaizen = {
--         enableDeprecatedCommentHint = false, -- to enable hints for '#' comments
--         enableDiagnostics = true, -- to enable/disable diagnostics
--         KamailioSourcePath = vim.fn.getcwd(),
--         loglevel = 3,
--       },
--     },
--   },
-- }
return {
  'IbrahimShahzad/KamaiZen',
  -- 'batoaqaa/KamaiZen',
  branch = 'master', -- or tag = 'v0.0.5'
  build = 'go build',
  opts = {
    settings = {
      kamaizen = {
        enableDeprecatedCommentHint = false, -- to enable hints for '#' comments
        enableDiagnostics = true, -- to enable/disable diagnostics
        KamailioSourcePath = '/path/to/kamailio', -- or use current dir vim.fn.getcwd()
        loglevel = 3,
      },
    },
  },
}
