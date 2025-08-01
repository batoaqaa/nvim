-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  -- event = 'VeryLazy', -- Sets the loading event to 'VimEnter'

  -- keys = {
  --   {
  --     '<leader>?',
  --     function()
  --       require('which-key').show({ global = false })
  --     end,
  --     desc = 'Buffer Local Keymaps (which-key)',
  --   },
  -- },
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    preset = 'modern', --"classic", --"helix", --
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    -- sort = { "order", "group", "manual", "mod" },
    sort = { 'local', 'order', 'group', 'alphanum', 'mod' },

    -- Document existing key chains
    spec = {
      -- { '<leader>b', group = '[B]uffer' },
      -- { '<leader>d', group = 'Delete' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>l', group = '[l]azy git' },
      { '<leader>r', group = 'LSP rename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
      { 'gl', group = ' LSP:' },
      { '[', group = 'prev' },
      { ']', group = 'next' },
      { 'g', group = 'goto' },
      { 'gs', group = 'surround' },
      { 'glw', group = ' LSP: workspace' },
      { 'z', group = 'fold' },
      {
        '<leader>b',
        group = 'buffer',
        expand = function()
          return require('which-key.extras').expand.buf()
        end,
      },
      {
        '<leader>w',
        group = 'windows',
        proxy = '<c-w>',
        expand = function()
          return require('which-key.extras').expand.win()
        end,
      },

      { '\\',        ':NvimTreeToggle<CR>',        { silent = true, desc = 'Toggle NvimTree' } },
      -- better descriptions
      { 'gx',        desc = 'Open with system app' },
      { '<leader>u', desc = '[U]ndo history' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
