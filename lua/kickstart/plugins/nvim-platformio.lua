return {
  -- 'batoaqaa/nvim-platformio.lua',
  'anurag3301/nvim-platformio.lua',
  lazy = false,
  dependencies = {
    { 'akinsho/nvim-toggleterm.lua' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    require('platformio').setup({
      lsp = 'clangd', --default: ccls, other option: clangd
      -- If you pick clangd, it also creates compile_commands.json
    })
  end,
  -- opts = {},
  cmd = {
    'Pioinit',
    'Piorun',
    'Piocmd',
    'Piolib',
    'Piomon',
    'Piodebug',
    'Piodb',
  },
}
