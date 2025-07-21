--
-- File: ~/.config/nvim/lua/plugins/blink-cmp.lua
-- Last Change: Sat, 12 Jul 2025 - 21:00:28
-- Author: Sergio Araujo

-- local NVIMHOME = require('core.environment').nvimhome()

return {
  'saghen/blink.cmp',
  -- build = nil,
  -- event = 'VimEnter',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/luasnip/' })
      end,
    },
    'folke/lazydev.nvim',
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/nvim-cmp' },

    -- ADIÇÃO: integração com nvim-autopairs
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {
        enable_check_bracket_line = true,
        disable_in_macro = true,
        disable_filetype = { 'TelescopePrompt' },
        disable_in_replace_mode = true,
        enable_afterquote = true,
        map_bs = false,
        map_c_h = true,
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          javascript = { 'template_string' },
          java = false,
        },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'", '<' },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment',
        },
        pairs_map = {
          ["'"] = "'",
          ['"'] = '"',
          ['('] = ')',
          ['['] = ']',
          ['{'] = '}',
          ['<'] = '>',
        },
      },
      config = function(_, opts)
        local npairs = require('nvim-autopairs')
        npairs.setup(opts)

        local cmp = require('cmp')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end,
    },
  },

  --- @module 'blink.cmp'
  opts = {
    keymap = {
      preset = 'super-tab',
      -- ['<Tab>'] = { 'insert_next', 'snippet_forward', 'fallback' },
      -- ['<S-Tab>'] = { 'insert_prev', 'snippet_backward', 'fallback' },
      -- ['<C-y>'] = { 'accept', 'fallback' },
      -- ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-e>'] = { 'hide', 'show' },
      -- ['<PageUp>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<PageDown>'] = { 'scroll_documentation_down', 'fallback' },
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

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
      },
      ghost_text = {
        enabled = false,
      },
    },

    sources = {
      default = { 'snippets', 'lsp', 'lazydev', 'buffer' },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        snippets = {
          score_offset = 200, -- ⬅️ snippets acima de todos
        },
      },
    },

    snippets = {
      preset = 'luasnip',
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
    },

    signature = {
      enabled = true,
    },

    cmdline = {
      enabled = false,
      keymap = {
        preset = 'cmdline',
        ['<Tab>'] = { 'insert_next' },
        ['<S-Tab>'] = { 'insert_prev' },
        ['<C-y>'] = { 'accept_and_enter', 'fallback' },
        -- ['<CR>'] = { 'accept_if_selected', 'enter', 'fallback' },
        -- ['<CR>'] = { 'accept_or_enter', 'fallback' },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' or type == '?' then
          return { 'buffer' }
        elseif type == ':' or type == '@' then
          return { 'cmdline' }
        end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}
-- vim: set ts=2 sw=2 tw=78 et fenc=utf-8 ft=lua nospell:
-- return {
--   'saghen/blink.cmp',
--   dependencies = { 'rafamadriz/friendly-snippets' },
--   version = '1.*',
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     keymap = {
--       preset = 'enter',
--       ['<C-y>'] = { 'select_and_accept' },
--     },
--     appearance = {
--       kind_icons = {
--         Text = ' ', -- Text = 1,
--         Method = 'ƒ ', -- Method = 2,
--         Function = ' ', -- Function = 3,
--         Constructor = '', -- Constructor = 4,
--         Field = '󰜢', -- Field = 5,
--         Variable = '󰀫', -- Variable = 6,
--         Class = '', -- Class = 7,
--         Interface = ' ', -- Interface = 8,
--         Module = ' ', -- Module = 9,
--         Property = '', -- Property = 10,
--         Unit = '󰑭', -- Unit = 11,
--         Value = ' ', -- Value = 12,
--         Enum = '', -- Enum = 13,
--         Keyword = '󰌋', -- Keyword = 14,
--         Snippet = '', -- Snippet = 15,
--         Color = '', -- Color = 16,
--         File = '', -- File = 17,
--         Reference = '󰈇', -- Reference = 18,
--         Folder = '', -- Folder = 19,
--         EnumMember = '', -- EnumMember = 20,
--         Constant = '', -- Constant = 21,
--         Struct = '', -- Struct = 22,
--         Event = '', -- Event = 23,
--         Operator = '󰆕', -- Operator = 24,
--         TypeParameter = '󰅲', -- TypeParameter = 25,
--       },
--       use_nvim_cmp_as_default = false,
--       nerd_font_variant = 'normal',
--     },
--     signature = { enabled = true },
--
--     completion = {
--       accept = {
--         -- experimental auto-brackets support
--         auto_brackets = {
--           enabled = true,
--         },
--       },
--       list = { -- used for 'enter' preset
--         selection = {
--           preselect = true,
--         },
--       },
--       menu = {
--         border = 'single',
--         draw = {
--           treesitter = { 'lsp' },
--         },
--       },
--       documentation = {
--         auto_show = true,
--         window = {
--           border = 'single',
--         },
--         auto_show_delay_ms = 200,
--       },
--       ghost_text = {
--         enabled = vim.g.ai_cmp,
--       },
--     },
--   },
--   opts_extend = { 'sources.default' },
-- }
