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
    vim.cmd.colorscheme 'melange'
  --end,
  --]]

  --[[ kanagawa colorscheme /
  'rebelot/kanagawa.nvim',
  opts = conf,
  config = function()
    vim.cmd.colorscheme 'kanagawa'
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

  --[[ catppuccin colorscheme /
  'catppuccin/nvim',
  opts = conf,
  name = 'catppuccin',
  init = function()
    vim.cmd.colorscheme('catppuccin')
    --end,
    --]]

  ---[[ tokyonight colorscheme /
  'folke/tokyonight.nvim',
  opts = conf,
  init = function()
    vim.cmd.colorscheme('tokyonight-night')
    --end,
    --]]

    --[[ gruvbox colorscheme /
  'ellisonleao/gruvbox.nvim',
  opts = {},
  init = function()
    vim.cmd.colorscheme 'gruvbox'
  --end,
  --]]

    vim.cmd.hi('Comment gui=none')
  end,
  --]]
}
