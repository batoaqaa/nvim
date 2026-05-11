return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
          '/.cache', -- Ignore the clangd cache folder at the project root
          '/.pio', -- Ignore PlatformIO build files
        },
      },
    })
  end,
}
-- return {
--   {
--     'nvim-neo-tree/neo-tree.nvim',
--     branch = 'v3.x',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'MunifTanjim/nui.nvim',
--       'nvim-tree/nvim-web-devicons', -- optional, but recommended
--     },
--     lazy = false, -- neo-tree will lazily load itself
--     opts = {
--       window = {
--         mappings = {
--           ['Y'] = function(state)
--             local node = state.tree:get_node()
--             local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
--
--             -- OS-specific ASCII tree command
--             local cmd
--             if vim.fn.has('win32') == 1 then
--               -- Windows: /A forces ASCII, /F includes files
--               cmd = string.format('tree /A /F "%s"', path)
--             else
--               -- Linux/macOS: --charset=ascii forces plain text
--               cmd = string.format('tree --charset=ascii --noreport "%s"', path)
--             end
--
--             local handle = io.popen(cmd)

--               return
--             end
--             local result = handle:read('*a')
--             handle:close()
--
--             if result and result ~= '' then
--               vim.fn.setreg('+', result) -- Copy to system clipboard
--               vim.notify('Copied plain ASCII tree to clipboard!')
--             else
--               vim.notify("Error: 'tree' command not found or folder empty.", vim.log.levels.ERROR)
--             end
--           end,
--         },
--       },
--     },
--   },
-- }
