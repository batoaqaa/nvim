-- bufkeymap('n', "<leader>dr", function() trouble("lsp_references") end, "References")
-- bufkeymap('n', "<leader>dd", function() trouble("document_diagnostics") end, "Document Diagnostics")
-- bufkeymap('n', "<leader>dw", function() trouble("workspace_diagnostics") end, "Workspace Diagnostics")
--   bufkeymap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
--   bufkeymap({ 'i', 'n' }, '<C-k>', vim.lsp.buf.signature_help, 'Show signature')
--   bufkeymap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   bufkeymap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
--   bufkeymap('n', 'gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
--   bufkeymap('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   bufkeymap('n', 'gr', vim.lsp.buf.references, 'List references')
--   bufkeymap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   bufkeymap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--   bufkeymap('n', '<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
--   bufkeymap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'List workspace symbols')
--   bufkeymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
--   bufkeymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
--   bufkeymap('n', '<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist folders')
--   bufkeymap({ 'n', 'x' }, '<F3>', function()
--     -- vim.lsp.buf.format { bufnr = buf_number, async = true }
--     require('conform').format({ bufnr = bufnr, async = true })
--   end, 'format buffer')
--   bufkeymap('n', '<leader>lh', function()
--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
--   end, '[l]sp [h]ints toggle')

-- bufkeymap('n', '[q', vim.cmd.cprev, 'Previous quickfix item')
-- bufkeymap('n', ']q', vim.cmd.cnext, 'Next quickfix item')
-- bufkeymap('n', '[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
-- bufkeymap('n', ']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
-- bufkeymap('n', '<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
-- bufkeymap('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
-- bufkeymap('n', "<leader>tt", function() trouble() end, "Toggle Trouble")
-- bufkeymap('n', "<leader>tq", function() trouble("quickfix") end, "Quickfix List")
local utils = require('custom.utils')
local general = {
  {
    name = 'Build',
    cmd = function()
      local command = 'pio run'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpb',
  },
  {
    name = 'Upload firmware',
    cmd = function()
      local command = 'pio run -t upload'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpuf',
  },
  {
    name = 'Upload data',
    cmd = function()
      local command = 'pio run -t uploadfs'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpud',
  },
  {
    name = 'Upload and monitor',
    cmd = function()
      local command = 'pio run -t upload -t monitor'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpum',
  },
  {
    name = '  Monitor',
    cmd = function()
      local command = 'pio device monitor'
      utils.ToggleTerminal(command, 'horizontal', 'Press [Ctrl+C] then press ENTER to exit')
    end,
    rtxt = 'gpdm',
  },
  {
    name = 'Clean',
    cmd = function()
      local command = 'pio run -t clean'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpcc',
  },
  {
    name = 'Clean full',
    cmd = function()
      local command = 'pio run -t fullclean'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpcf',
  },
  {
    name = 'Devices',
    cmd = function()
      local command = 'pio device list'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpdl',
  },
}
local dependencies = {
  {
    name = 'List',
    cmd = function()
      local command = 'pio pkg list'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gppl',
  },
  {
    name = 'Outdated',
    cmd = function()
      local command = 'pio pkg outdated'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpod',
  },
  {
    name = 'Update',
    cmd = function()
      local command = 'pio pkg update'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpup',
  },
}
local advance = {
  {
    name = 'Test',
    cmd = function()
      local command = 'pio test'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gptt',
  },
  {
    name = 'Check',
    cmd = function()
      local command = 'pio check'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gptc',
  },
  {
    name = 'Pre Debug',
    cmd = function()
      local command = 'pio debug'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gppd',
  },
  {
    name = 'Verbose build',
    cmd = function()
      local command = 'pio run -v'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpvb',
  },
  {
    name = 'Verbose uplad',
    cmd = function()
      local command = 'pio run -v -t upload'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpvu',
  },
  {
    name = 'Verbose test',
    cmd = function()
      local command = 'pio -v test'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpvt',
  },
  {
    name = 'Verbose check',
    cmd = function()
      local command = 'pio -v check'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpvc',
  },
  {
    name = 'Compilation Database',
    cmd = function()
      local command = 'pio run -v -t compiledb'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpdb',
  },
}
local remote = {
  {
    name = 'Remote upload',
    cmd = function()
      local command = 'pio remote run -t upload'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpru',
  },
  {
    name = 'Remote test',
    cmd = function()
      local command = 'pio remote test'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gprt',
  },
  {
    name = 'Remote monitor',
    cmd = function()
      local command = 'pio remote device monitor'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gprm',
  },
  {
    name = 'Remote devices',
    cmd = function()
      local command = 'pio remote device list'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gprd',
  },
}
-- {
--   title = 'Miscellaneous',
--   is_open = false,
--   entries = {
--     { title = 'Upgrade PlatformIO Core', command = 'pio upgrade' },
--   },
-- },
local miscellaneous = {
  {
    name = 'Upgrade PlatformIO Core',
    cmd = function()
      local command = 'pio upgrade'
      utils.ToggleTerminal(command, 'float')
    end,
    rtxt = 'gpuc',
  },
}
local platformio = {
  {
    name = 'General',
    hl = 'Exblue',
    items = general,
  },
  {
    name = 'Dependencies',
    hl = 'Exblue',
    items = dependencies,
  },
  {
    name = 'Advance',
    hl = 'Exblue',
    items = advance,
  },
  {
    name = 'Remote',
    hl = 'Exblue',
    items = remote,
  },
  {
    name = 'Miscellaneous',
    hl = 'Exblue',
    items = miscellaneous,
  },
}
local lsp = {
  {
    name = 'Goto Definition',
    cmd = vim.lsp.buf.definition,
    rtxt = 'gd',
  },
  {
    name = 'Goto Declaration',
    cmd = vim.lsp.buf.declaration,
    rtxt = 'gD',
  },
  {
    name = 'Goto Implementation',
    cmd = vim.lsp.buf.implementation,
    rtxt = 'gi',
  },
  { name = 'separator' },
  {
    name = 'Show signature help',
    cmd = vim.lsp.buf.signature_help,
    rtxt = '<leader>sh',
  },
  {
    name = 'Add workspace folder',
    cmd = vim.lsp.buf.add_workspace_folder,
    rtxt = '<leader>wa',
  },
  {
    name = 'Remove workspace folder',
    cmd = vim.lsp.buf.remove_workspace_folder,
    rtxt = '<leader>wr',
  },
  {
    name = 'Show References',
    cmd = vim.lsp.buf.references,
    rtxt = 'gr',
  },
  { name = 'separator' },
  {
    name = 'Format Buffer',
    cmd = function()
      local ok, conform = pcall(require, 'conform')
      if ok then
        conform.format({ lsp_fallback = true })
      else
        vim.lsp.buf.format()
      end
    end,
    rtxt = '<leader>fm',
  },
  {
    name = 'Code Actions',
    cmd = vim.lsp.buf.code_action,
    rtxt = '<leader>ca',
  },
}
local menu = {
  {
    name = 'Platformio',
    hl = 'Exblue',
    items = platformio,
  },
  { name = 'separator' },
  {
    name = '  Lsp Actions',
    hl = 'Exblue',
    items = lsp,
  },
}

return {
  { 'nvzone/volt', lazy = true },
  { 'nvzone/menu', lazy = true },
  opts = {
    vim.keymap.set('n', '<C-t>', function()
      require('menu').open(menu, { mouse = true, border = false })
    end, {}),
    --[[mouse users + nvimtree users!]]
    -- vim.keymap.set({ 'n', 'v' }, '<RightMouse>', function()
    --   vim.cmd([[
    --     aunmenu PopUp
    --     autocmd! nvim.popupmenu
    --   ]])
    --
    --   require('menu.utils').delete_old_menus()
    --
    --   vim.cmd.exec('"normal! \\<RightMouse>"')
    --
    --   -- clicked buf
    --   local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    --   local options = vim.bo[buf].ft == 'NvimTree' and 'nvimtree' or 'default'
    --
    --   require('menu').open(menu, { mouse = true })
    -- end, {}),
  },
}
