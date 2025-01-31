local opts = require('custom.plugins.lsp.opts')
-- local M = {}

local config = require('kamaizen.config')

-- function M.setup(user_config)
config.setup({})
--config.setup(user_config)

local lsp_config = {
  name = 'KamaiZen',
  cmd = { '/home/batoaqaa/.local/bin/KamaiZen' },
  filetypes = { 'cfg', 'kamailio_cfg', 'kamailio' },
  root_dir = vim.fn.getcwd(),
  capabilities = opts.capabilities,
  settings = {
    kamaizen = config.config,
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
    print(args.buf)
  end,
})
-- end
-- vim.api.nvim_create_autocmd('FileType', {
--   --pattern = 'kamailio_cfg',
--   pattern = 'cfg',
--   callback = function(args)
--     require('kamaizen').setup(args)
--   end,
-- })

-- return M
