return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    left = {
      {
        -- ft = 'neo-tree',
        ft = 'nvim-tree',
        -- title = 'Neo-Tree',
        title = 'Nvim-Tree',
        size = { width = 30 },
      },
    },
    -- 2. Put your terminal at the bottom (It fills the entire bottom width)
    bottom = {
      {
        ft = 'pio_terminal', -- or "terminal" if using standard Neovim terminals
        title = 'Terminal',
        size = { height = 15 },
      },
    },
    -- Optional: Global options to fine-tune how corners behave
    options = {
      left = { size = 30 },
      bottom = { size = 15 },
    },
  },
}
