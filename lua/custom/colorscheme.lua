local overrides = function() --// colors)
  local p = require('custom.colors')
  --// local p = colors.palette
  return {
    CursorLine = {
      bold = true,
      italic = true,
      bg = p.sumiInk5,
    },
    Visual = {
      bold = true,
    },
    TreesitterContextBottom = {
      link = 'Visual',
    },
    IlluminatedCurWord = {
      italic = true,
    },
    IlluminatedWordText = {
      link = 'CursorLine',
      italic = true,
    },
    IlluminatedWordRead = {
      link = 'CursorLine',
      italic = true,
    },
    IlluminatedWordWrite = {
      link = 'CursorLine',
      italic = true,
    },
    Folded = {
      bg = p.sumiInk3,
    },
    StatusColumnFoldClosed = {
      fg = p.springViolet1,
      bold = false,
    },
    DashboardHeader = {
      fg = p.peachRed,
      bg = p.sumiInk3,
    },
    DashboardIcon = {
      fg = p.springBlue,
      bg = p.sumiInk3,
    },
    DashboardDesc = {
      fg = p.fujiWhite,
      bg = p.sumiInk3,
      italic = true,
    },
    DashboardKey = {
      fg = p.lightBlue,
      bg = p.sumiInk3,
      bold = true,
    },
    Pmenu = {
      fg = p.fujiWhite,
      bg = p.waveBlue1,
    },
    PmenuSel = {
      fg = p.waveBlue1,
      bg = p.springViolet2,
      bold = true,
    },
    UfoFoldedBg = {
      bg = p.waveBlue1,
      bold = true,
    },
    IdentScope = {
      fg = p.oniViolet2,
    },
    MarkdownFence = {
      bg = p.sumiInk1,
      italic = true,
    },
  }
end

local conf = {
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,
  dimInactive = true,
  terminalColors = true,
  transparent_background = true,
  colors = {
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
  telescope = {
    enabled = true,
  },
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = { 'italic' },
      hints = { 'italic' },
      warnings = { 'italic' },
      information = { 'italic' },
      ok = { 'italic' },
    },
    underlines = {
      errors = { 'underline' },
      hints = { 'underline' },
      warnings = { 'underline' },
      information = { 'underline' },
      ok = { 'underline' },
    },
    inlay_hints = {
      background = true,
    },
  },
  mason = false,
  flash = true,
  mini = {
    enabled = true,
    indentscope_color = '', -- catppuccin color (eg. `lavender`) Default: text
  },
  neotree = false,
  dap = true,
  cmp = true,
  overrides = overrides,
}

return {
  --// return {
  --//   'rebelot/kanagawa.nvim',
  --//   config = config('kanagawa'),
  --//   lazy = false,
  --//   priority = 1000,
  --// }
  priority = 1000, -- Make sure to load this before all the other start plugins.
  lazy = false, -- make sure we load this during startup if it is your main colorscheme

  --[[
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    vim.cmd('colorscheme rose-pine-dawn')
    --]]
  --[[
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      variant = 'dawn', -- Light variant
      disable_italics = false,
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    })
    vim.cmd.colorscheme('rose-pine')
    --]]
  --[[ github colorscheme /
  -- github_dark
  -- github_dark_default
  -- github_dark_dimmed
  -- github_dark_high_contrast
  -- github_dark_colorblind
  -- github_dark_tritanopia
  -- github_light
  -- github_light_default
  -- github_light_high_contrast
  -- github_light_colorblind
  -- github_light_tritanopia
  'projekt0n/github-nvim-theme',
  config = function()
    require('github-theme').setup()
    vim.cmd.colorscheme 'github_dark_tritanopia'
  --end,
  --]]

  --[[ winteriscoming colorscheme /
  'atmosuwiryo/vim-winteriscoming',
  opts = {},
  config = function()
    vim.cmd.colorscheme 'WinterIscoming-dark-blue-color-theme'
    -- end,
    --]]

  --[[ Melange colorscheme /
  --//{ 'savq/melange-nvim', opts = { conf } },
  'savq/melange-nvim',
  config = function()
    vim.cmd.colorscheme('melange')
    --end,
    --]]

  --[[ kanagawa colorscheme /
  'rebelot/kanagawa.nvim',
  opts = conf,
  config = function()
    vim.cmd.colorscheme('kanagawa')
    --end,
    --]]

  --[[ material colorscheme /
  'sainnhe/sonokai',
  init = function()
    vim.cmd.colorscheme 'sonokai'
  --end,
  --]]

  --[[ palenight colorscheme /
  'drewtempelmeyer/palenight.vim',
  opts = {},
  config = function()
    vim.cmd.colorscheme 'palenight'
  --end,
  --]]

  ---[[ catppuccin colorscheme /
  'catppuccin/nvim',
  opts = conf,
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup({
      flavour = 'latte', -- light theme

      float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      -- ... other options ...
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
      },

      -- This is where you configure integrations and their floating windows
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        mason = true,
        mini = true,
        telescope = {
          enabled = true,
          -- style = "nvchad" -- optional: makes telescope borderless
        },
        which_key = true,
        barbar = true,
        markdown = true,
        lightspeed = true,
        ts_rainbow = true,
        leap = true,

        -- Native LSP: Customize the appearance of LSP-related floats
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true, -- gives inlay hints a background color
          },
        },

        -- LSP Saga: Another popular LSP UI plugin that uses floats extensively
        lsp_saga = true,

        -- Notify: For customizing notification popups (floats)
        notify = true,

        -- Noice: Modern UI plugin that replaces cmdline and messages (uses floats)
        noice = true,

        -- DAP: Debug Adapter Protocol UI
        dap = true,
        dap_ui = true,
      },

      -- Custom highlights specifically for floating windows
      custom_highlights = function(colors)
        return {
          -- Customize the floating window border color
          FloatBorder = { fg = colors.lavender, bg = colors.base },

          -- Customize the background of floating windows
          NormalFloat = { bg = colors.base },

          -- Customize the title of floating windows
          FloatTitle = { fg = colors.text, bg = colors.surface1, style = { 'bold' } },

          -- For Telescope floating window specifically
          TelescopeBorder = { fg = colors.lavender, bg = colors.base },
          TelescopeNormal = { bg = colors.base },
          TelescopePreviewBorder = { fg = colors.peach, bg = colors.base },
          TelescopePreviewTitle = { fg = colors.base, bg = colors.peach },
          TelescopePromptBorder = { fg = colors.sapphire, bg = colors.mantle },
          TelescopePromptNormal = { fg = colors.text, bg = colors.mantle },
          TelescopePromptTitle = { fg = colors.mantle, bg = colors.sapphire },
          TelescopeResultsBorder = { fg = colors.base, bg = colors.base },
          TelescopeResultsTitle = { fg = colors.base, bg = colors.base },

          -- For Noice.nvim floating windows
          NoicePopupmenu = { bg = colors.mantle },
          NoicePopupmenuBorder = { fg = colors.lavender },

          -- For LSP Saga floating windows
          SagaBorder = { fg = colors.mauve },
          SagaNormal = { bg = colors.mantle },
        }
      end,
    })
    -- Enable theme
    -- require('catppuccin').load()
    vim.cmd.colorscheme('catppuccin')
    --end,
    --]]

    --[[ tokyonight colorscheme /
  'folke/tokyonight.nvim',
  opts = conf,
  config = function()
    require('tokyonight').setup({
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.fg_gutter -- Custom statusline background
      end,
      on_highlights = function(hl, colors)
        -- Custom highlights
        hl.LineNr = { fg = colors.comment }
        hl.CursorLineNr = { fg = colors.fg, bold = true }
        hl.Visual = { bg = colors.fg_gutter }

        -- Better contrast for search results
        hl.IncSearch = { bg = colors.orange, fg = colors.bg }
        hl.Search = { bg = colors.orange, fg = colors.bg }

        -- Custom telescope highlights
        hl.TelescopeSelection = { bg = colors.fg_gutter }
        hl.TelescopeBorder = { fg = colors.fg_gutter, bg = colors.bg }
      end,
    })
    vim.cmd('colorscheme tokyonight-day')
    --end,
    --]]

    --[[ onedark
  "navarasu/onedark.nvim",
  config = function()
    require('onedark').setup {
      style = 'deep'
    }
    -- Enable theme
    require('onedark').load()
    --]]

    --[[ gruvbox colorscheme /
  -- 'sainnhe/gruvbox-material',
  -- config = function()
  --   vim.g.gruvbox_material_enable_italic = true
  --   vim.cmd.colorscheme('gruvbox-material')

  -- 'sainnhe/edge',
  -- config = function()
  --   vim.g.edge_enable_italic = true
  --   vim.cmd.colorscheme('edge')

  'sainnhe/everforest',
  config = function()
    -- require('everforest').setup {
    --   contrast = "hard",
    --   palette_overrides = {
    --     dark0_hard = "#000000",
    --   },
    -- }
    vim.g.everforest_background = 'hard'     -- 'medium'  'soft'
    vim.g.everforest_foreground = 'material' -- 'original'  'mix'
    -- vim.g.everforest_colors_override = { bg0 = { '#202020', '234' }, bg2 = { '#282828', '235' } }
    -- vim.g.everforest_colors_override = { bg0 = { '#11111b', '234' }, bg2 = { '#11111b', '235' } }
    -- vim.g.everforest_enable_bold = '1'
    -- vim.g.everforest_transparent_background = '2'

    vim.g.everforest_enable_italic = true
    vim.cmd.colorscheme('everforest')

    -- 'sainnhe/sonokai',
    -- config = function()
    --   vim.g.sonokai_enable_italic = true
    --   vim.cmd.colorscheme('sonokai')

    -- 'ellisonleao/gruvbox.nvim',
    -- opts = {},
    -- init = function()
    --   -- vim.cmd.colorscheme 'gruvbox'
    --   --end,
    --   --]]
    --
    --[[ jellybeans colorscheme /
  "wtfox/jellybeans.nvim",
  config = function()
    -- Default (vibrant dark)
    vim.cmd [[colorscheme jellybeans]]
    -- -- Vibrant light
    -- vim.cmd [[colorscheme jellybeans-light]]
    --
    -- -- Muted dark
    -- vim.cmd [[colorscheme jellybeans-muted]]
    --
    -- -- Muted light
    -- vim.cmd [[colorscheme jellybeans-muted-light]]
    --
    -- -- Mono dark
    -- vim.cmd [[colorscheme jellybeans-mono]]
    --
    -- -- Mono light
    -- vim.cmd [[colorscheme jellybeans-mono-light]]
  end,

  --   vim.cmd.hi('Comment gui=none')
  --]]
}
