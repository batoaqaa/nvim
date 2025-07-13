-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --   --config = true,
  --   opts = {
  --     rocks = { 'kamailio-nvim' }, -- specifies a list of rocks to install
  --     -- luarocks_build_args = { '--with-lua=/my/path' }, -- extra options to pass to luarocks's configuration script
  --   },
  -- },
  require('custom/colorscheme'),

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  { import = 'plugins' },

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- transparent background
  { 'xiyaowong/transparent.nvim', opts = { lazy = false } },

  require('custom/lsp-config'),
  require('custom/conform'),
  -- require('custom/lint'),
  -- require('custom/nvim-platformio'),
  -- require('custom/which-key'),
}, {
  rocks = { enabled = false },
  git = { log = { '--since=3 days ago' } },
  ui = {
    custom_keys = { false },
    defaults = {
      lazy = true,
    },
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'none',
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,
    title = nil, ---@type string only works when border is not "none"
    title_pos = 'center', ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    icons = vim.g.have_nerd_font and {} or {
      cmd = ' ',
      config = '🛠',
      debug = '● ',
      event = '📅',
      favorite = ' ',
      ft = ' ',
      init = '⚙',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = '💻',
      require = '󰢱 ',
      source = '📄',
      start = ' ',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
  },
  -- install = { colorscheme = { 'catppuccin' } },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'rplugin',
        'editorconfig',
        'matchparen',
        'matchit',
      },
    },
  },
  checker = { enabled = false },
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- vim: ts=2 sts=2 sw=2 et
