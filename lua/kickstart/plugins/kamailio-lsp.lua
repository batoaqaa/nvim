return {
  'batoaqaa/KamaiZen',
  dependencies = { 'batoaqaa/KamaiZen', build = 'go build' },
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
