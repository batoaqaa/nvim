K = {}
--Lua functions in combination with the option expr = true handles keycodes automatically
function K.lspKeymaps(client, bufnr)
  local bufkeymap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc }) -- noremap by default
  end
  -- Disable defaults
  pcall(vim.keymap.del, 'n', 'gra')
  pcall(vim.keymap.del, 'n', 'gri')
  pcall(vim.keymap.del, 'n', 'grn')
  pcall(vim.keymap.del, 'n', 'grr')
  pcall(vim.keymap.del, 'n', 'gO')
  pcall(vim.keymap.del, 'n', 'K')
  --
  -- Quickfix list
  bufkeymap('n', '[q', vim.cmd.cprev, 'Previous quickfix item')
  bufkeymap('n', ']q', vim.cmd.cnext, 'Next quickfix item')

  -- Diagnostic keymaps
  bufkeymap('n', '[d', '<cmd>vim.diagnostic.goto_prev()<CR>', 'Go to previous [d]iagnostic message')
  bufkeymap('n', ']d', '<cmd>vim.diagnostic.goto_next()<CR>', 'Go to next [d]iagnostic message')
  bufkeymap('n', 'gle', vim.diagnostic.open_float, 'Show diagnostic [e]rror messages')
  -- bufkeymap('n', 'gle', '<Cmd>Telescope diagnostics<CR>', 'Show diagnostic [e]rror messages')
  bufkeymap('n', 'glq', vim.diagnostic.setloclist, 'Open diagnostic [q]uickfix list')
  --
  -- stylua: ignore start
  -- << local trouble = require("trouble").toggle
  -- << bufkeymap('n', "<leader>tt", function() trouble() end, "Toggle Trouble")
  -- << bufkeymap('n', "<leader>tq", function() trouble("quickfix") end, "Quickfix List")
  -- << bufkeymap('n', "<leader>dr", function() trouble("lsp_references") end, "References")
  -- << bufkeymap('n', "<leader>dd", function() trouble("document_diagnostics") end, "Document Diagnostics")
  -- << bufkeymap('n', "<leader>dw", function() trouble("workspace_diagnostics") end, "Workspace Diagnostics")
  -- stylua: ignore end
  --
  if client.server_capabilities.hoverProvider then
    bufkeymap('n', 'glk', vim.lsp.buf.hover, 'Hover Documentation')
  end
  if client.server_capabilities.signatureHelpProvider then
    bufkeymap({ 'i', 'n' }, 'gls', vim.lsp.buf.signature_help, 'Show signature')
  end
  if client.server_capabilities.declarationProvider then
    bufkeymap('n', 'glD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
  end
  if client.server_capabilities.definitionProvider then
    bufkeymap('n', 'gld', vim.lsp.buf.definition, 'Go to [d]efinition')
    -- bufkeymap('n', 'gld', '<Cmd>Telescope lsp_definitions<CR>', '[G]oto [D]efinition')
  end
  if client.server_capabilities.typeDefinitionProvider then
    bufkeymap('n', 'glt', vim.lsp.buf.type_definition, 'Goto [t]ype definition')
    -- bufkeymap('n', 'glt', '<Cmd>Telescope lsp_type_definitions<CR>', 'Goto [t]ype definition')
  end
  if client.server_capabilities.implementationProvider then
    bufkeymap('n', 'gli', vim.lsp.buf.implementation, 'Goto [i]mplementation')
    -- bufkeymap('n', 'gli', '<Cmd>Telescope lsp_implementations<CR>', 'Goto [i]mplementation')
  end

  -- bufkeymap('n', 'glr', '<Plug>(CodeAction, implementation, rename, references)', 'CodeAction, implementation, rename, references')
  if client.server_capabilities.referencesProvider then
    -- bufkeymap('n', 'gr', vim.lsp.buf.references, 'List references')
    bufkeymap('n', 'glr', '<cmd>Telescope lsp_references<CR>', 'Goto [r]eferences')
    -- bufkeymap('n', 'glr', '<Cmd>Telescope lsp_references<CR>', '[G]oto [R]eferences')
  end
  if client.server_capabilities.renameProvider then
    -- bufkeymap('n', '<F2>', vim.lsp.buf.rename, 'Rename symbol')
    bufkeymap('n', 'glR', vim.lsp.buf.rename, '[R]ename')
  end
  if client.server_capabilities.codeActionProvider then
    bufkeymap('n', 'gla', vim.lsp.buf.code_action, 'Code [a]ction')
  end

  if client.server_capabilities.documentSymbolProvider then
    bufkeymap('n', 'glwd', vim.lsp.buf.document_symbol, '[D]ocument symbols')
    -- bufkeymap('n', 'glwd', <Cmd>Telescope lsp_document_symbols<CR>, '[D]ocument [S]ymbols')
  end
  if client:supports_method('workspace/symbol') then
    -- if client.server_capabilities.workspaceSymbolProvider then
    bufkeymap('n', 'glww', vim.lsp.buf.workspace_symbol, 'List [w]orkspace symbols')
    -- bufkeymap('n', 'glww', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  end
  if client.server_capabilities.workspace then
    bufkeymap('n', 'glwa', vim.lsp.buf.add_workspace_folder, 'Workspace [a]dd folder')
    bufkeymap('n', 'glwr', vim.lsp.buf.remove_workspace_folder, 'Workspace [r]emove folder')
    bufkeymap('n', 'glwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist folders')
  end
  --
  if client.supports_method('textDocument/switchSourceHeader') then
    bufkeymap('n', 'glws', '<cmd>LspClangdSwitchSourceHeader<cr>', '[S]witch Source/Header (C/C++)')
  end

  if client.supports_method('textDocument/formatting') then
    -- if client.server_capabilities.documentFormattingProvider then
    bufkeymap({ 'n', 'x' }, 'glf', function()
      vim.lsp.buf.format({ bufnr = bufnr, async = true })
      -- require('conform').format({ bufnr = bufnr, async = true })
    end, '[f]ormat buffer')
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
    bufkeymap('n', 'glh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, '[h]ints toggle')
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
