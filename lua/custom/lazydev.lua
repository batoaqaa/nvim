return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ':h:h:h'), words = { 'platformio' } },
      },
    },
  },
}
