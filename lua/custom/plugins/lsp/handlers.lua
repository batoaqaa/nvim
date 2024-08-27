--<
local _augroups = {}
local get_augroup = function(client)
  if not _augroups[client.id] then
    local group_name = 'kickstart-lsp-format-' .. client.name
    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
    _augroups[client.id] = id
  end

  return _augroups[client.id]
end
-->

--< Start LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --desc = 'LSP actions',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf_number = args.buf
    --
    if client then
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
      local bufkeymap = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = buf_number, noremap = true, silent = true, desc = 'LSP: ' .. desc })
      end
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
      bufkeymap('n', '<leader>ds', '<cmd>vs | lua vim.lsp.buf.definition()<cr>', 'Goto definition (v-split)')
      bufkeymap('n', '<leader>dh', '<cmd>sp | lua vim.lsp.buf.definition()<cr>', 'Goto definition (h-split)')
      --
      -- local id = vim.tbl_get(args, 'data', 'client_id')
      -- local client = id and vim.lsp.get_client_by_id(id)
      -- print('Attaching to: ' .. client.name .. ' attached to buffer ' .. buf_number)
      if client.server_capabilities.hoverProvider then
        bufkeymap('n', 'K', vim.lsp.buf.hover, 'Show documentation')
      end
      if client.server_capabilities.signatureHelpProvider then
        bufkeymap({ 'i', 'n' }, '<C-k>', vim.lsp.buf.signature_help, 'Show signature')
      end
      if client.server_capabilities.declarationProvider then
        bufkeymap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
      end
      if client.server_capabilities.definitionProvider then
        -- bufkeymap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        bufkeymap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      end
      if client.server_capabilities.typeDefinitionProvider then
        bufkeymap('n', 'go', vim.lsp.buf.type_definition, 'Go to type definition')
      end
      if client.server_capabilities.implementationProvider then
        bufkeymap('n', 'gI', vim.lsp.buf.implementation, 'Go to implementation')
      end
      if client.server_capabilities.referencesProvider then
        bufkeymap('n', 'gr', vim.lsp.buf.references, 'List references')
      end
      if client.server_capabilities.renameProvider then
        bufkeymap('n', '<F2>', vim.lsp.buf.rename, 'Rename symbol')
      end
      if client.server_capabilities.codeActionProvider then
        bufkeymap('n', '<F4>', vim.lsp.buf.code_action, 'Code action')
      end

      if client.server_capabilities.documentSymbolProvider then
        bufkeymap('n', '<leader>ds', vim.lsp.buf.document_symbol, 'List document symbols')
      end
      if client.server_capabilities.workspaceSymbolProvider then
        bufkeymap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'List workspace symbols')
      end
      if client.server_capabilities.workspace then
        bufkeymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
        bufkeymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
        bufkeymap('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List workspace folders')
      end

      --
      if client.server_capabilities.documentFormattingProvider then
        -- if client.supports_method 'textDocument/formatting' then
        bufkeymap({ 'n', 'x' }, '<F3>', function()
          vim.lsp.buf.format { async = true }
        end, 'format buffer')
        --
        -- Format the current buffer on save
        --local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = buf_number,
          group = get_augroup(client), --fmt_group,
          desc = 'Fromat current buffer',
          callback = function()
            vim.lsp.buf.format {
              bufnr = buf_number,
              async = false,
              timeout_ms = 10000,
              id = client.id,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end
      --
      if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        bufkeymap('n', '<leader>lh', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf_number }, { bufnr = buf_number })
        end, '[l]sp [h]ints toggle')
        ------------------------------------------------------------------------------
        -- Initial inlay hint display.
        -- Idk why but without the delay inlay hints aren't displayed at the very start.
        vim.defer_fn(function()
          local mode = vim.api.nvim_get_mode().mode
          vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = buf_number })
        end, 500)

        --autocommands to only disable inlay_hint in insert mode and enabled in other modes
        local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })
        vim.api.nvim_create_autocmd('InsertEnter', {
          group = inlay_hints_group,
          desc = 'Disable inlay hints',
          buffer = buf_number,
          callback = function()
            vim.lsp.inlay_hint.enable(false, { bufnr = buf_number })
          end,
        })
        vim.api.nvim_create_autocmd('InsertLeave', {
          group = inlay_hints_group,
          desc = 'Enable inlay hints',
          buffer = buf_number,
          callback = function()
            vim.lsp.inlay_hint.enable(true, { bufnr = buf_number })
          end,
        })
        ------------------------------------------------------------------------------
      end
      --
      if client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = buf_number,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = buf_number,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
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
    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        vim.highlight.on_yank {
          higroup = 'IncSearch', -- see `:highlight` for more options
          timeout = 200,
        }
      end,
    })
    --
    vim.cmd [[autocmd FileType * set formatoptions-=ro]]
    --
  end,
})
-- --> End LspAttach autocommand
