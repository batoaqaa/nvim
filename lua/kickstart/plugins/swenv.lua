return {
  'AckslD/swenv.nvim',
  config = function()
    require('swenv').setup({
      -- Your configuration goes here
    })
    require('swenv.api').set_venv(vim.env.VIRTUAL_ENV)
  end,
}
