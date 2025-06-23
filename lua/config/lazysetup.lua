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
  { 'xiyaowong/transparent.nvim', opst = { lazy = false } },

  { import = 'plugins' },
  require('custom/lsp-config'),
  require('custom/nvim-platformio'),
  --
  -- "gc" to comment visual regions/lines
  -- { 'numToStr/Comment.nvim', opts = {} },
  --
  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  -- require('kickstart/plugins/gitsigns'),
  -- require('kickstart/plugins/which-key'),
  -- require('kickstart/plugins/buffdelete'),
  -- require('kickstart/plugins/telescope'),
  -- require('kickstart/plugins/conform'),
  -- require('kickstart/plugins/lazygit'),
  -- require('kickstart/plugins/colorscheme'),
  -- -- require('kickstart/plugins/colorizer'),
  -- require('kickstart/plugins/todo-comments'),
  -- require('kickstart/plugins/trouble'),
  -- require('kickstart/plugins/clangd-extensions'),
  -- require('kickstart/plugins/lazydev'),
  -- require('kickstart/plugins/blink-cmp'),
  -- require('kickstart/plugins/mini'),
  -- require('kickstart/plugins/bigfile'),
  -- require('kickstart/plugins/treesitter'),

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require('kickstart/plugins/indent_line'),
  -- -- require('kickstart/plugins/lint'),
  -- -- require('kickstart/plugins/neo-tree'),
  -- require('kickstart/plugins/nvim-tree'),
  -- require('kickstart/plugins/flash'),
  -- require('kickstart/plugins/oil'),
  -- require('kickstart/plugins/bufferline'),
  -- require('kickstart/plugins/undotree'),
  -- require('kickstart/plugins/nvim-platformio'),
  -- require('kickstart/plugins/kamailio-lsp'),
  -- require('kickstart/plugins/toggleterm'),
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --

  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
}, {
  rocks = { enabled = false },
  git = { log = { '--since=3 days ago' } },
  ui = {
    custom_keys = { false },
    defaults = {
      lazy = true,
    },
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  -- install = { colorscheme = { 'tokyonight' } },
  -- install = { colorscheme = { 'kanagawa' } },
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
