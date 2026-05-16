return {
  'stevearc/aerial.nvim',
  branch = 'nvim-0.11',
  -- tag = 'v2.7.0',
  opts = {
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
      vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end,
    filter_kind = {
      'Function',
      'Module',
      'Method',
    },
    open_automatic = true,
  },
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

-- return {
--   'hedyhli/outline.nvim',
--   lazy = true,
--   cmd = { 'Outline', 'OutlineOpen' },
--   keys = { -- Example mapping to toggle outline
--     { '<leader>a', '<cmd>Outline<CR>', desc = 'Toggle outline' },
--   },
--   opts = {
--     symbols = {
--       filter = { 'Function' },
--     },
--     -- Your setup opts here
--   },
-- }

-- return {
--   'ThePrimeagen/refactoring.nvim',
--   dependencies = {
--     'lewis6991/async.nvim',
--   },
--   lazy = false,
--   config = function()
--     require('refactoring').setup({})
--     local keymap = vim.keymap
--
--     keymap.set({ 'n', 'x' }, '<leader>rs', function()
--       -- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
--       require('refactoring').select_refactor()
--     end, { desc = 'Select refactor' })
--   end,
-- }
