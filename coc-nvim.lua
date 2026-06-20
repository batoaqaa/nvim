return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    -- Automatically install the exact VS Code clangd extension wrapper
    vim.fn['coc#util#install_extension']({ 'coc-clangd' })
  end,
}
