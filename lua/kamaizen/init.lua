local opts = require('custom.plugins.lsp.opts')

local lsp_config = {
  name = 'KamaiZen',
  cmd = { '/home/batoaqaa/.local/bin/KamaiZen' },
  filetypes = { 'cfg', 'kamailio_cfg', 'kamailio' },
  root_dir = vim.fn.getcwd(),
  capabilities = opts.capabilities,
  settings = {
    kamaizen = {
      enableDeprecatedCommentHint = false, -- to enable hints for '#' comments
      KamailioSourcePath = vim.fn.getcwd(),
      loglevel = 3,
    },
  },
  -- handlers = {
  --   ['workspace/configuration'] = function(_, _, params)
  --     return { config.config }
  --   end,
  -- },
}

local client = vim.lsp.start_client(lsp_config)

if not client then
  vim.notify('KamaiZen LSP failed to start')
  return
end

-- vim.lsp.buf_attach_client(user_config.buf, client)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cfg',
  callback = function(args)
    vim.lsp.buf_attach_client(args.buf, client)
  end,
})
