return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<C-y>'] = { 'select_and_accept' },
    },
    appearance = {
      kind_icons = {
        Text = ' ', -- Text = 1,
        Method = 'ƒ ', -- Method = 2,
        Function = ' ', -- Function = 3,
        Constructor = '', -- Constructor = 4,
        Field = '󰜢', -- Field = 5,
        Variable = '󰀫', -- Variable = 6,
        Class = '', -- Class = 7,
        Interface = ' ', -- Interface = 8,
        Module = ' ', -- Module = 9,
        Property = '', -- Property = 10,
        Unit = '󰑭', -- Unit = 11,
        Value = ' ', -- Value = 12,
        Enum = '', -- Enum = 13,
        Keyword = '󰌋', -- Keyword = 14,
        Snippet = '', -- Snippet = 15,
        Color = '', -- Color = 16,
        File = '', -- File = 17,
        Reference = '󰈇', -- Reference = 18,
        Folder = '', -- Folder = 19,
        EnumMember = '', -- EnumMember = 20,
        Constant = '', -- Constant = 21,
        Struct = '', -- Struct = 22,
        Event = '', -- Event = 23,
        Operator = '󰆕', -- Operator = 24,
        TypeParameter = '󰅲', -- TypeParameter = 25,
      },
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'normal',
    },
    signature = { enabled = true },

    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      list = { -- used for 'enter' preset
        selection = {
          preselect = true,
        },
      },
      menu = {
        border = 'single',
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = 'single',
        },
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
  },
  opts_extend = { 'sources.default' },
}
