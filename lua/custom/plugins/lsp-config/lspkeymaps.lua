K = {}

function K.lspKeymaps(client, bufnr)
  local bufkeymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP: ' .. desc })
  end
  -- Quickfix list
  bufkeymap('n', '[q', vim.cmd.cprev, 'Previous quickfix item')
  bufkeymap('n', ']q', vim.cmd.cnext, 'Next quickfix item')
  -- Diagnostic keymaps
  bufkeymap('n', '[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
  bufkeymap('n', ']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
  bufkeymap('n', '<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
  bufkeymap('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
  --
  -- stylua: ignore start
  local trouble = require("trouble").toggle
  bufkeymap('n', "<leader>tt", function() trouble() end, "Toggle Trouble")
  bufkeymap('n', "<leader>tq", function() trouble("quickfix") end, "Quickfix List")
  bufkeymap('n', "<leader>dr", function() trouble("lsp_references") end, "References")
  bufkeymap('n', "<leader>dd", function() trouble("document_diagnostics") end, "Document Diagnostics")
  bufkeymap('n', "<leader>dw", function() trouble("workspace_diagnostics") end, "Workspace Diagnostics")
  -- stylua: ignore end
  --
  if client.server_capabilities.hoverProvider then
    bufkeymap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  end
  if client.server_capabilities.signatureHelpProvider then
    bufkeymap({ 'i', 'n' }, '<C-k>', vim.lsp.buf.signature_help, 'Show signature')
  end
  if client.server_capabilities.declarationProvider then
    bufkeymap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end
  if client.server_capabilities.definitionProvider then
    bufkeymap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    -- bufkeymap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  end
  if client.server_capabilities.typeDefinitionProvider then
    bufkeymap('n', 'gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
  end
  if client.server_capabilities.implementationProvider then
    bufkeymap('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  end
  if client.server_capabilities.referencesProvider then
    bufkeymap('n', 'gr', vim.lsp.buf.references, 'List references')
    -- bufkeymap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  end
  if client.server_capabilities.renameProvider then
    -- bufkeymap('n', '<F2>', vim.lsp.buf.rename, 'Rename symbol')
    bufkeymap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  end
  if client.server_capabilities.codeActionProvider then
    -- bufkeymap('n', '<F4>', vim.lsp.buf.code_action, 'Code action')
    bufkeymap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  end

  if client.server_capabilities.documentSymbolProvider then
    bufkeymap('n', '<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
    -- bufkeymap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  end
  if client.server_capabilities.workspaceSymbolProvider then
    bufkeymap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'List workspace symbols')
    -- bufkeymap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  end
  if client.server_capabilities.workspace then
    bufkeymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
    bufkeymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
    bufkeymap('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist folders')
  end
  --
  if client.server_capabilities.documentFormattingProvider then
    --   -- if client.supports_method 'textDocument/formatting' then
    bufkeymap({ 'n', 'x' }, '<F3>', function()
      -- vim.lsp.buf.format { bufnr = buf_number, async = true }
      require('conform').format({ bufnr = bufnr, async = true })
    end, 'format buffer')
    --   --
    -- vim.api.nvim_clear_autocmds({
    --   group = get_augroup(client),
    --   buffer = buf_number,
    -- })
    -- --
    -- LSP format the current buffer on save
    --local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     buffer = buf_number,
    --     group = get_augroup(client),
    --     desc = 'Fromat current buffer',
    --     callback = function()
    --       vim.lsp.buf.format {
    --         bufnr = buf_number,
    --         async = false,
    --         timeout_ms = 10000,
    --         id = client.id,
    --         filter = function(c)
    --           return c.id == client.id
    --         end,
    --       }
    --     end,
    --   })
  end
  --
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    bufkeymap('n', '<leader>lh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, '[l]sp [h]ints toggle')
    ------------------------------------------------------------------------------
    -- -- Initial inlay hint display.
    -- -- Idk why but without the delay inlay hints aren't displayed at the very start.
    -- vim.defer_fn(function()
    --   local mode = vim.api.nvim_get_mode().mode
    --   vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = buf_number })
    -- end, 500)
    --
    -- --autocommands to only disable inlay_hint in insert mode and enabled in other modes
    -- local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })
    -- vim.api.nvim_create_autocmd('InsertEnter', {
    --   group = inlay_hints_group,
    --   desc = 'Disable inlay hints',
    --   buffer = buf_number,
    --   callback = function()
    --     vim.lsp.inlay_hint.enable(false, { bufnr = buf_number })
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd('InsertLeave', {
    --   group = inlay_hints_group,
    --   desc = 'Enable inlay hints',
    --   buffer = buf_number,
    --   callback = function()
    --     vim.lsp.inlay_hint.enable(true, { bufnr = buf_number })
    --   end,
    -- })
    ------------------------------------------------------------------------------
  end
end

return K
