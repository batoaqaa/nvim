return {
  {
    'hrsh7th/nvim-cmp',
    event = 'LspAttach',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          -- if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          if jit.os == 'Windows' then
            --print("Windows 11")
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind.nvim',
      { 'lukas-reineke/lsp-format.nvim', opts = {} },
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional
    },
    --
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup({})
      --
      local kind_icons = {
        Text = '',
        Method = 'm',
        Function = '󰊕',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = ' ',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = ' ',
      }

      cmp.setup({

        -- preselect = require('cmp.types').cmp.PreselectMode.Item,
        -- completion = {
        --   autocomplete = {
        --     require('cmp.types').cmp.TriggerEvent.TextChanged,
        --   },
        --   completeopt = 'menu,menuone,noselect',
        --   keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
        --   keyword_length = 1,
        -- },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },

        window = {
          completion = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            winblend = vim.o.pumblend,
            scrolloff = 0,
            col_offset = 0,
            side_padding = 1,
            scrollbar = true,
          },
          documentation = {
            max_height = math.floor(40 * (40 / vim.o.lines)),
            max_width = math.floor((40 * 2) * (vim.o.columns / (40 * 2 * 16 / 9))),
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            winhighlight = 'FloatBorder:NormalFloat',
            winblend = vim.o.pumblend,
          },
        },

        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
          disallow_symbol_nonprefix_matching = true,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          --
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        }),

        snippet = {
          expand = vim.fn.has('nvim-0.10') == 1 and function(args)
            vim.snippet.expand(args.body)
          end or function(_)
            error('snippet engine is not configured.')
          end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          buffer = 1,
          path = 1,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 9 },
          { name = 'nvim_lua', priority = 8 },
          { name = 'buffer', priority = 7, keyword_length = 3, max_item_count = 10 },
          { name = 'lazydev', priority = 6 },
          { name = 'dictionary', priority = 5, keyword_length = 5, keyword_pattern = [[\w\+]], max_item_count = 4 },
          { name = 'path', priority = 4 },
          { name = 'calc', priority = 3 },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'buffer', keyword_length = 3 },
        }),
        --
        formatting = {
          expandable_indicator = true,
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, vim_item)
            local menu_icon = {
              nvim_lsp = 'λ [LSP]',
              luasnip = '⋗ [Snip]',
              buffer = 'Ω [Buff]',
              path = '🖫  [Path]',
              nvim_lua = 'Π [Lua]',
            }

            -- for codeium
            -- if vim_item.kind == "Codeium" then
            --     vim_item.menu = "[󱚤 ]"
            --     vim_item.kind = " "
            --     return vim_item
            -- end

            vim_item.menu = menu_icon[entry.source.name]
            -- vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
            return vim_item
          end,
        },

        confirmation = {
          default_behavior = require('cmp.types').cmp.ConfirmBehavior.Insert,
          get_commit_characters = function(commit_characters)
            return commit_characters
          end,
        },

        sorting = {
          priority_weight = 1.0,
          comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
            cmp.config.compare.length,
            require('clangd_extensions.cmp_scores'),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
          },
        },
      })
    end,
  },
}
