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

local opts = require('custom.plugins.lsp-config.opts')
--< Start LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --desc = 'LSP actions',
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local buf_number = args.buf

    local lspkeymaps = require('custom.plugins.lsp-config.lspkeymaps')
    --
    if client then
      -- vim.lsp.set_log_level 'trace'
      print('Attaching to: ' .. client.name .. ' attached to buffer ' .. buf_number)
      ------------------------------------------------------------------
      -- if client.name == 'clangd' and not vim.g.have_project_conf then
      --   vim.g.have_project_conf = true
      --   -- local client = vim.lsp.start(vim.tbl_extend('force', vim.lsp.config.basedpyright, { root_dir = root }),
      --   --   { attach = false })
      --   -- if client then
      --   --   vim.lsp.buf_attach_client(0, client)
      --   -- end
      --   local uv = vim.uv or vim.loop
      --   local path = vim.fn.getcwd()
      --   local fname = string.format('%s/clangd.json', path)
      --   if uv.fs_stat(fname) then
      --     local ok, result = pcall(vim.fn.readfile, fname)
      --     if ok then
      --       -- vim.lsp.disable(client.name)
      --       result = table.concat(result)
      --       result = vim.json.decode(result)
      --       local config = vim.deepcopy(vim.lsp.config.clangd)
      --       config.cmd = result.cmd
      --       -- config.root_dir = client.root_dir
      --
      --       -- vim.lsp.buf_detach_client(buf_number, client_id)
      --       vim.lsp.config(client.name, config)
      --       -- vim.lsp.enable(client.name)
      --       -- vim.lsp.stop_client(client_id, true)
      --       client_id = vim.lsp.start(config, {
      --         reuse_client = function()
      --           return true
      --         end,
      --         bufnr = buf_number,
      --         attach = true,
      --         silent = false,
      --       })
      --       -- client_id = vim.lsp.start(vim.tbl_extend('force', vim.lsp.config.basedpyright, { root_dir = root }),
      --       -- vim.lsp.buf_attach_client(buf_number, client_id)
      --       return
      --     end
      --   end
      -- end
      -- if client.name == 'tsserver' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      -- if client.name == 'lua_ls' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      ------------------------------------------------------------------
      --
      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      ---[[ Format and autoimport on Save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          if client:supports_method('textDocument/formatting') then
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end

          if client:supports_method('textDocument/codeAction') then
            local function apply_code_action(action_type)
              local ctx = { only = action_type, diagnostics = {} }
              local actions = vim.lsp.buf.code_action({ context = ctx, apply = true, return_actions = true })

              -- only apply if code action is available
              if actions and #actions > 0 then
                vim.lsp.buf.code_action({ context = ctx, apply = true })
              end
            end
            apply_code_action({ 'source.fixAll' })
            apply_code_action({ 'source.organizeImports' })
          end
        end,
      })
      ---]]

      ---[[ Disable default formatting
      if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false
      end

      if client.name == 'lua_ls' then
        client.server_capabilities.documentFormattingProvider = false
      end
      ---]]

      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end
      vim.diagnostic.config({ current_line = true })
      --
      ------------------------------------------------------------------
      lspkeymaps.lspKeymaps(client, buf_number)
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
