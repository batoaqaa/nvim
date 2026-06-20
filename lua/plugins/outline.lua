return {
  'hedyhli/outline.nvim',
  keys = { -- Example mapping to toggle outline
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    symbols = {
      -- filter = { 'Function' }, -- Your setup opts here
    },
  },
  -- config = function()
  --   -- Example mapping to toggle outline
  --   vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
  --     { desc = "Toggle Outline" })
  --
  --   require("outline").setup {
  --     -- Your setup opts here (leave empty to use defaults)
  --   }
  -- end,
}
