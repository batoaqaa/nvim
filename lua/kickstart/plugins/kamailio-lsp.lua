return {
  'batoaqaa/kamailio-lsp',
  -- 'batoaqaa/kamaizen.nvim',
  dependencies = {
    { 'IbrahimShahzad/KamaiZen', build = 'go build' },
  },
  -- lazy = true,
  opts = {
    settings = {
      kamaizen = {
        enableDeprecatedCommentHint = false, -- to enable hints for '#' comments
        KamailioSourcePath = vim.fn.getcwd(),
        loglevel = 3,
      },
    },
  },
}
