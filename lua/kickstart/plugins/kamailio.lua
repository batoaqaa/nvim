return {
  'batoaqaa/kamailio-nvim', -- replace this with your {user_name}/{repo_name}
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
