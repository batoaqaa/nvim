--<
-- local _augroups = {}
-- local get_augroup = function(client)
--   if not _augroups[client.id] then
--     local group_name = 'kickstart-lsp-format-' .. client.name
--     _augroups[client.id] = vim.api.nvim_create_augroup(group_name, { clear = true })
--   end
--
--   return _augroups[client.id]
-- end
-->

--< Start LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --desc = 'LSP actions',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf_number = args.buf

    local lspkeymaps = require('custom.plugins.lsp-config.lspkeymaps')
    --
    if client then
      -- vim.lsp.set_log_level 'trace'
      print('Attaching to: ' .. client.name .. ' attached to buffer ' .. buf_number)
      ------------------------------------------------------------------
      -- if client.name == 'clangd' then
      --   return
      -- end
      -- if client.name == 'tsserver' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      --
      -- if client.name == 'lua_ls' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      ------------------------------------------------------------------
      --
      lspkeymaps.LspKeymaps(client, buf_number)
      --
      if client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = buf_number,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        --
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = buf_number,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
        --
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event.buf })
          end,
        })
        --
      end
    end
    --
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })
    --
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })
    --
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      underline = true,
      virtual_text = {
        spacing = 5,
        min = vim.diagnostic.severity.HINT,
      },
      update_in_insert = true,
    })
    --
    vim.cmd([[autocmd FileType * set formatoptions-=ro]])
    --
  end,
})
-- --> End LspAttach autocommand
