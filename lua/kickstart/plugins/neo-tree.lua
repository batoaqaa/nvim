return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  -- keys = {
  --   { '\\', ':Neotree filesystem reveal float<CR>', { desc = 'NeoTree reveal' } },
  --   -- { '<C-n>', ':Neotree filesystem reveal right<CR>', {} },
  --   -- { '<leader>bf', ':Neotree buffers reveal float<CR>', {} },
  -- },
  keys = {
    {
      '\\',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          source = 'filesystem',
          position = 'left',
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
  },
  opts = {
    -- default_component_configs = {
    --   indent = {
    --     with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    --     expander_collapsed = "",
    --     expander_expanded = "",
    --     expander_highlight = "NeoTreeExpander",
    --   },
    --   git_status = {
    --     symbols = {
    --       unstaged = "󰄱",
    --       staged = "󰱒",
    --     },
    --   },
    -- },
    popup_border_style = 'rounded',
    sources = {
      'filesystem',
      'buffers',
    },
    default_source = 'filesystem',

    source_selector = {
      winbar = false,
      statusline = false,
      sources = {
        { source = 'filesystem' },
        { source = 'buffers' },
      },
      separator = { left = '▏', right = '▕' },
    },

    --window = { position = 'left' },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          '.github',
          '.gitignore',
          'package-lock.json',
        },
        never_show = { '.git' },
      },
    },
    buffers = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true, -- when true, empty directories will be grouped together
      show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
      -- are mark as "unloaded". Turn this on to view these unloaded buffer.
      terminals_first = false, -- when true, terminals will be listed before file buffers
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['bd'] = 'buffer_delete',
          ['i'] = 'show_file_details',
          ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
          ['oc'] = { 'order_by_created', nowait = false },
          ['od'] = { 'order_by_diagnostics', nowait = false },
          ['om'] = { 'order_by_modified', nowait = false },
          ['on'] = { 'order_by_name', nowait = false },
          ['os'] = { 'order_by_size', nowait = false },
          ['ot'] = { 'order_by_type', nowait = false },
        },
      },
    },
  },
}
