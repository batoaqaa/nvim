-- WARNING: Place these two lines at the absolute top of your main 'init.lua' file!
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- return {
--   'nvim-tree/nvim-tree.lua',
--   dependencies = {
--     'nvim-tree/nvim-web-devicons',
--   },
--   config = function()
--     -- Set termguicolors to enable highlight groups
--     vim.opt.termguicolors = true
--
--     require('nvim-tree').setup({
--       -- UPDATED: This replaces the deprecated 'sort_by' property
--       sort = {
--         sorter = 'case_sensitive',
--       },
--       view = {
--         width = 30,
--         side = 'left',
--       },
--       renderer = {
--         group_empty = true,
--         icons = {
--           show = {
--             file = true,
--             folder = true,
--             folder_arrow = true,
--             git = true,
--           },
--         },
--       },
--       filters = {
--         dotfiles = false,
--         custom = { '^\\.git$' },
--       },
--       git = {
--         enable = true,
--         ignore = false,
--       },
--     })
--
--     -- Global keymaps
--     vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle File Explorer' })
--     vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { silent = true, desc = 'Find Current File in Explorer' })
--   end,
-- }

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  opts = {},
  --   --       window = {
  --   --         mappings = {
  --   --           ['Y'] = function(state)
  --   --             local node = state.tree:get_node()
  --   --             local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
  --   --
  --   --             -- OS-specific ASCII tree command
  --   --             local cmd
  --   --             if vim.fn.has('win32') == 1 then
  --   --               -- Windows: /A forces ASCII, /F includes files
  --   --               cmd = string.format('tree /A /F "%s"', path)
  --   --             else
  --   --               -- Linux/macOS: --charset=ascii forces plain text
  --   --               cmd = string.format('tree --charset=ascii --noreport "%s"', path)
  --   --             end
  --   --
  --   --             local handle = io.popen(cmd)
  --
  --   --               return
  --   --             end
  --   --             local result = handle:read('*a')
  --   --             handle:close()
  --   --
  --   --             if result and result ~= '' then
  --   --               vim.fn.setreg('+', result) -- Copy to system clipboard
  --   --               vim.notify('Copied plain ASCII tree to clipboard!')
  --   --             else
  --   --               vim.notify("Error: 'tree' command not found or folder empty.", vim.log.levels.ERROR)
  --   --             end
  --   --           end,
  --   --         },
  --   --       },
  --   --     },
  --   -- },
}
