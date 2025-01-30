--https://ibrahimshahzad.github.io/posts/writing_lsp_for_kamailio_cfg_p1/
vim.api.nvim_create_autocmd('FileType', {
  --pattern = 'kamailio_cfg',
  pattern = 'cfg',
  callback = function(args)
    require('kamaizen').setup(args)
  end,
})
