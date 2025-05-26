return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  keys = {
    {
      '\\',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          source = 'filesystem',
          position = 'left',
          -- width = "20%"
        })
      end,
      desc = 'Filesystem (root dir)',
    },
    {
      '<leader>bf',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          source = 'filesystem',
          position = 'float',
        })
      end,
      desc = 'Filesystem (root dir)',
    },
    {
      '<leader>bg',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          source = 'git_status',
          position = 'left',
        })
      end,
      desc = 'git_status',
    },
  },
  opts = {
    window = {
      position = 'left',
      width = '20%',
    },
    default_source = 'filesystem',
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      -- "document_symbols",
    },
    source_selector = {
      winbar = false,
      statusline = false,
      sources = {
        { source = 'filesystem' },
        { source = 'buffers' },
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      bind_to_cwd = false,
      follow_current_file = {
        enabled = false,
        leave_dirs_open = false,
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
      },
    },
    -- default_component_configs = {
    --   git_status = {
    --     symbols = {
    --       -- Change type
    --       -- added = '✚',
    --       -- deleted = '✖',
    --       -- modified = '',
    --       -- renamed = '󰁕',
    --       -- Status type
    --       untracked = '',
    --       ignored = '',
    --       unstaged = ' ',
    --       staged = '',
    --       conflict = '',
    --     },
    --   },
    -- },
  },
}
