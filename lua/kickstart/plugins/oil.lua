return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = false,
      -- keymaps = {
      --   ['g?'] = 'actions.show_help',
      --   ['<CR>'] = 'actions.select',
      --   ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
      --   ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
      --   ['<C-t>'] = { 'actions.select', opts = { tab = true } },
      --   ['<C-p>'] = 'actions.preview',
      --   ['<C-c>'] = 'actions.close',
      --   ['<C-l>'] = 'actions.refresh',
      --   ['-'] = 'actions.parent',
      --   ['_'] = 'actions.open_cwd',
      --   ['`'] = 'actions.cd',
      --   ['~'] = { 'actions.cd', opts = { scope = 'tab' } },
      --   ['gs'] = 'actions.change_sort',
      --   ['gx'] = 'actions.open_external',
      --   ['g.'] = 'actions.toggle_hidden',
      --   ['g\\'] = 'actions.toggle_trash',
      -- },
    })
    vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
  end,
}
