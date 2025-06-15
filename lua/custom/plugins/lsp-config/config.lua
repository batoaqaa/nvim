----------------------------------------------------------------------------------
require('vim.lsp.protocol').CompletionItemKind = {
  ' ', -- Text
  'ƒ ', -- Method
  '󰊕 ', -- Function
  ' ', -- Constructor
  ' ', -- Field
  ' ', -- Variable
  '', -- Class
  ' ', -- Interface
  ' ', -- Module
  '', -- Property
  '', -- Unit
  ' ', -- Value
  '了', -- Enum
  ' ', -- Keyword
  ' ', -- Snippet
  '', -- Color
  '', -- File
  ' ', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  ' ', -- Operator
  '', -- TypeParameter
}
local ensure_installed = {
  'black',
  'biome',
  'clang-format',
  'isort',
  'prettier',
  'prettierd',
  'pyright',
  'shfmt',
  'stylua',
  'yamlfmt',
  'yamllint',
  'debugpy',
  'debugpy',
  'isort',
  'mypy',
  'pylint',
}

----------------------------------------------------------------------------------
local opts = require('custom.plugins.lsp-config.opts')
-- INFO: 1
vim.lsp.config('*', {
  capabilities = opts.capabilities,
  root_markers = { '.git' },
})
--
-- INFO: 2 Defined in <rtp>/lsp/clangd.lua        override 1
-- INFO: 4 Defined in <rtp>/after/lsp/clangd.lua  override 1 & 2 & 3
-- suggest setting it in the after/ if you want to be sure it is setting your config and not overwritten by a default from a plugin.
local lsp_files = {}
local lsp_dir = vim.fn.stdpath('config') .. '/after/lsp/'
for _, file in ipairs(vim.fn.globpath(lsp_dir, '*.lua', false, true)) do
  -- Read the first line of the file
  local f = io.open(file, 'r')
  local first_line = f and f:read('*l') or ''
  if f then
    f:close()
  end
  -- Only include the file if it doesn't start with "-- disable" (space characters or no)
  if not first_line:match('^%-%-%s*disable.*') then --https://www.lua.org/pil/20.2.html
    local name = vim.fn.fnamemodify(file, ':t:r')   -- `:t` gets filename, `:r` removes extension
    table.insert(lsp_files, name)
  end
end
vim.lsp.enable(lsp_files)
vim.list_extend(ensure_installed, lsp_files)

-- INFO: 3 Defined in custom/plugins/lsp-config/lang-servers.lua     override 1 & 2
local lang_servers = require('custom.plugins.lsp-config.lang-servers')
for srv_name, settings in pairs(lang_servers) do
  vim.lsp.config(srv_name, settings)
end
vim.lsp.enable(vim.tbl_keys(lang_servers))
vim.list_extend(ensure_installed, vim.tbl_keys(lang_servers))
require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
----------------------------------------------------------------------------------
--< Start LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --desc = 'LSP actions',
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    if client then
      -- vim.lsp.set_log_level 'trace'
      print('Attaching to: ' .. client.name .. ' attached to buffer ' .. bufnr)
      ------------------------------------------------------------------
      if client.name == 'clangd' then
        vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
          local method_name = 'textDocument/switchSourceHeader'
          local params = vim.lsp.util.make_text_document_params(bufnr)
          client.request(method_name, params, function(err, result)
            if err then
              error(tostring(err))
            end
            if not result then
              vim.notify('corresponding file cannot be determined')
              return
            end
            vim.cmd.edit(vim.uri_to_fname(result))
          end, bufnr)
        end, { desc = 'Switch between source/header' })
      end
      -- if client.name == 'tsserver' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      -- if client.name == 'lua_ls' then
      --   client.server_capabilities.documentFormattingProvider = false
      -- end
      ------------------------------------------------------------------
      --- Skip this if you are using blink
      -- if client:supports_method('textDocument/completion', { bufnr = bufnr }) then
      --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- end
      -- vim.diagnostic.config({
      --   current_line = true,
      --   virtual_lines = {
      --     current_line = true,
      --   },
      -- })
      -- vim.cmd([[set completeopt+=noselect]])
      ------------------------------------------------------------------

      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      ---[[ Format and autoimport on Save
      if not client:supports_method('textDocument/willSaveWaitUntil', { bufnr = bufnr }) then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
          buffer = args.buf,
          callback = function()
            if client:supports_method('textDocument/formatting', { bufnr = bufnr }) then
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
            if client:supports_method('textDocument/codeAction', { bufnr = bufnr }) then
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
      end
      ------------------------------------------------------------------
      if client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        --
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
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
      local lspkeymaps = require('custom.plugins.lsp-config.lspkeymaps')
      lspkeymaps.lspKeymaps(client, bufnr)
    end
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

-- Special config for lazy buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lazy',
  callback = function()
    vim.diagnostic.config({
      signs = false,
      virtual_text = true,
      virtual_lines = false,
      underline = false,
    })
  end,
})

-- Toggle virtual text and show diagnostics on cursor hold
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if vim.bo.filetype == 'lazy' then
      return
    end

    local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = current_line })

    vim.diagnostic.config({
      virtual_text = vim.tbl_isempty(diagnostics) and { spacing = 4, prefix = '●' } or false,
    })

    -- Only show float when there are diagnostics
    if not vim.tbl_isempty(diagnostics) then
      vim.diagnostic.open_float(nil, { focusable = false })
    end
  end,
})
