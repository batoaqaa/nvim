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
    filesystem = {
      use_libuv_file_watcher = true,
      --   bind_to_cwd = false,
      --   -- hijack_netrw_behavior = 'open_current',
      follow_current_file = { enabled = true },
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
        -- fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        --   ["<C-j>"] = "move_cursor_down",
        --   ["<C-k>"] = "move_cursor_up",
        -- }
      },
      --   filtered_items = {
      --     visible = true,
      --     hide_dotfiles = false,
      --     hide_gitignored = true,
      --     hide_by_name = {
      --       '.github',
      --       '.gitignore',
      --       'package-lock.json',
      --     },
      --     never_show = { '.git' },
      --   },
    },

    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '✚',
          deleted = '✖',
          modified = '',
          renamed = '󰁕',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = ' ',
          staged = '',
          conflict = '',
        },
      },
    },
  },
}
