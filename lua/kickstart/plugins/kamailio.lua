return {
  'batoaqaa/kamailio-nvim', -- replace this with your {user_name}/{repo_name}
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  },
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
