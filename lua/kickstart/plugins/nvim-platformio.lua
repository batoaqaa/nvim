return {
  'anurag3301/nvim-platformio.lua',
  lazy = false,
  dependencies = {
    { 'akinsho/nvim-toggleterm.lua' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-lua/plenary.nvim' },
  },
  -- config = function()
  --   require('platformio.nvim').setup {}
  -- end,
  -- opts = {},
  cmd = {
    'Pioinit',
    'Piorun',
    'Piocmd',
    'Piolib',
    'Piomon',
    'Piodebug',
  },
}
