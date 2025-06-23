return {
  -- 'IbrahimShahzad/KamaiZen',
  'batoaqaa/KamaiZen',
  -- tag = 'v0.1.2', -- or branch = 'master'
  build = 'go build',
  opts = {
    settings = {
      kamaizen = {
        enableDeprecatedCommentHint = false,      -- to enable hints for '#' comments
        enableDiagnostics = true,                 -- to enable/disable diagnostics
        KamailioSourcePath = '/path/to/kamailio', -- or use current dir vim.fn.getcwd()
        loglevel = 3,
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   if client then
  --     print('Attaching to: ' .. client.name .. ' attached to buffer ' .. bufnr)
  --     ------------------------------------------------------------------
  --     local bufkeymap = function(mode, keys, func, desc)
  --       vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP: ' .. desc })
  --     end
  --     -- Diagnostic keymaps
  --     bufkeymap('n', '[d', vim.diagnostic.jump({ count = -1, float = true }), 'Go to previous [D]iagnostic message')
  --     bufkeymap('n', ']d', vim.diagnostic.jump({ count = 1, float = true }), 'Go to next [D]iagnostic message')
  --     bufkeymap('n', 'e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
  --     bufkeymap('n', 'q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
  --     --
  --     if client.server_capabilities.hoverProvider then
  --       bufkeymap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  --     end
  --     if client.server_capabilities.definitionProvider then
  --       bufkeymap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  --     end
  --   end
  -- end,
}
