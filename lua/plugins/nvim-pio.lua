return {
  'batoaqaa/nvim-pio',
  -- lazy = true,
  lazy = false,
  -- init = function(self)
  --   if vim.fn.filereadable('platformio.ini') == 1 then
  --     require('lazy').load({ plugins = { self.name } })
  --   else
  --     vim.api.nvim_create_user_command('Pioinit', function()
  --       require('lazy').load({ plugins = { self.name } })
  --       vim.cmd('Pioinit')
  --     end, { nargs = '*' })
  --   end
  -- end,
  dependencies = {
    { 'akinsho/toggleterm.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'folke/which-key.nvim' },
  },
  config = function()
    local nvimpio = require('nvimpio')
    nvimpio.setup({
      pio = {
        pio_runtime_dir = '~/.platformio',
        pio_storage_dir = '~/.platformio',
      },
      clangd = {
        support = true,
        install = false,
      },
    })
  end,
}
-- 'batoaqaa/nvim-platformio.lua',
-- lazy = true,
-- -- This is the "Overture". It checks the CWD before loading.
-- init = function(self)
--   local is_ini = vim.fn.filereadable('platformio.ini') == 1
--   if is_ini then
--     require('lazy').load({ plugins = { self.name } })
--   else
--     -- If not a project, just give them the command to start one
--     vim.api.nvim_create_user_command('Pioinit', function()
--       require('lazy').load({ plugins = { self.name } })
--       require('nvimpio.pioInit').pioInit()
--     end, { desc = 'Bootstrap PIO' })
--   end
-- end,
-- 'anurag3301/nvim-platformio.lua',
--
-- cmd = { 'Pioinit', 'Piorun', 'Piocmdh', 'Piocmdf', 'Piolib', 'Piomon', 'Piodebug', 'Piodb' },
-- ft = 'platformio',
-- event = 'VeryLazy',
-- event = { 'BufReadPost platformio.ini' },
-- event = { 'BufReadPre platformio.ini', 'BufNewFile platformio.ini' },
-- lazy = vim.g.platformioRootDir ~= nil,
-- event = 'User PioLoad',

-- optional: cond used to enable/disable platformio
-- based on existance of platformio.ini file and .pio folder in cwd.
-- You can enable platformio plugin, using :Pioinit command
--
-- The init function runs on every startup BEFORE the plugin loads
-- init = function(self)
--   local has_ini = vim.fn.filereadable('platformio.ini') == 1
--   -- local has_pio = vim.fn.isdirectory('.pio') == 1
--
--   if has_ini then --and has_pio then
--     -- If project detected, tell lazy.nvim to load this plugin NOW
--     require('lazy').load({ plugins = { self.name } })
--   else
--     self.cmd = { 'Pioinit' }
--     -- If not, only create the 'Pioinit' command
--     vim.api.nvim_create_user_command('Pioinit', function()
--       -- Load the plugin manually when the command is run
--       require('lazy').load({ plugins = { self.name } })
--       -- require('nvimpio.pioInit').pioInit()
--       vim.cmd('Pioinit')
--     end, { desc = 'Bootstrap PIO' })
--   end
-- end,
-- init = function(self)
--   -- 1. If already loaded, do nothing
--   if require('lazy.core.config').plugins[self.name]._.loaded then
--     return
--   end
--
--   if vim.fn.filereadable('platformio.ini') == 1 then
--     require('lazy').load({ plugins = { self.name } })
--   else
--     -- 2. Temporary command
--     vim.api.nvim_create_user_command('Pioinit', function(opts)
--       -- Load the plugin
--       require('lazy').load({ plugins = { self.name } })
--
--       -- 3. Re-run the command. Since the plugin is now loaded,
--       -- it calls the "real" :Pioinit version from your plugin code.
--       -- 'opts.args' ensures any arguments passed are preserved.
--       vim.cmd('Pioinit ' .. opts.args)
--     end, { nargs = '*' })
--   end
-- end,
-- init = function(self)
--   -- 1. Check if it's already loaded to prevent redundant logic
--   if require('lazy.core.config').plugins[self.name]._.loaded then
--     return
--   end
--
--   -- 2. Check for the file
--   if vim.fn.filereadable('platformio.ini') == 1 then
--     require('lazy').load({ plugins = { self.name } })
--   else
--     -- 3. Create the command if we aren't in a PIO project
--     vim.api.nvim_create_user_command('Pioinit', function()
--       require('lazy').load({ plugins = { self.name } })
--       require('nvimpio.pioInit').pioInit()
--     end, { desc = 'Bootstrap PIO' })
--   end
-- end,
-- cond = function()
--   return vim.fn.isdirectory('.pio') == 1
-- end,
-- cmd = 'Pioinit',
-- init = function()
--   vim.api.nvim_create_user_command('Pioinit', function()
--     require('lazy').load({ plugins = { 'nvimpio' } })
--     require('nvimpio.pioInit').pioInit()
--   end, {})
-- end,
--
-- cond = function()
--   -- local platformioRootDir = vim.fs.root(vim.fn.getcwd(), { 'platformio.ini' }) -- cwd and parents
--   local platformioRootDir = (vim.fn.filereadable('platformio.ini') == 1) and vim.fn.getcwd() or nil
--   if platformioRootDir and vim.fs.find('.pio', { path = platformioRootDir, type = 'directory' })[1] then
--     -- if platformio.ini file and .pio folder exist in cwd, enable plugin to install plugin (if not istalled) and load it.
--     vim.g.platformioRootDir = platformioRootDir
--   elseif (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
--     -- if nvim-platformio not installed, enable plugin to install it first time
--     vim.g.platformioRootDir = vim.fn.getcwd()
--   else -- if nvim-platformio.lua installed but disabled, create Pioinit command
--     vim.api.nvim_create_user_command('Pioinit', function() --available only if no platformio.ini and .pio in cwd
--       vim.api.nvim_create_autocmd('User', {
--         pattern = { 'LazyRestore', 'LazyLoad' },
--         once = true,
--         callback = function(args)
--           if args.match == 'LazyRestore' then
--             require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
--           elseif args.match == 'LazyLoad' then
--             vim.notify('PlatformIO loaded', vim.log.levels.INFO, { title = 'PlatformIO' })
--             vim.cmd('Pioinit')
--           end
--         end,
--       })
--       vim.g.platformioRootDir = vim.fn.getcwd()
--       require('lazy').restore({ plguins = { 'nvim-platformio.lua' }, show = false })
--     end, {})
--   end
--   return vim.g.platformioRootDir ~= nil
-- end,
--
--

-- vim.api.nvim_exec_autocmds('User', {
--     pattern = 'MyCustomEvent',
--     data = 'Hello from the data attribute!', -- This value goes into args.data
--     -- You can also specify a buffer or other options here
--     -- buf = vim.api.nvim_get_current_buf(),
-- })
--??
-- local pioConfig = {
--   lspClangd = {
--     enabled = true,
--     attach = {
--       enabled = true,
--       keymaps = true,
--     },
--   },
--   -- menu_key = "<leader>\\", -- replace this menu key  to your convenience
--   -- menu_name = "PlatformIO", -- replace this menu name to your convenience
--   -- debug = false,
-- }
-- local pok, platformio = pcall(require, 'platformio')
-- if pok then
--   -- print("here" .. vim.inspect(pioConfig))
--   platformio.setup(pioConfig)
-- end
--??
-- opts = {
--   lspClangd = {
--     enabled = true,
--     attach = {
--       enabled = true,
--       keymaps = true,
--     },
--   },
-- config = function()
-- local pok, nvimpio = pcall(require, 'nvimpio')
-- if pok then
-- 2. Immediate check: If we are already in a PIO project, setup NOW
-- local nvimpio = require('nvimpio')
-- -- nvimpio.setup()
-- nvimpio.setup({
--   pio = {
--     auto_update_path = true,
--     notify_on_missing = true,
--   },
--   lspClangd = {
--     enabled = true,
--     attach = {
--       enabled = true,
--       keymaps = true,
--     },
--   },
-- })
-- local nvimpio = require('nvimpio')
-- -- nvimpio.setup()
-- nvimpio.setup({
--   pio = {
--     auto_update_path = true,
--     notify_on_missing = true,
--   },
--   clangd = {
--     support = true,
--     install = false,
--   },
-- })
-- lsp = 'clangd', --default: ccls, other option: clangd
-- clangd_source = 'compiledb', -- value: ccls | compiledb, For detailed explation check :help platformio-clangd_source
-- If you pick clangd, it also creates compile_commands.json

-- Uncomment out following line to enable platformio menu.
-- menu_key = '<leader>\\', -- replace this menu key  to your convenience
-- menu_name = 'PlatformIO', -- replace this menu name to your convenience

-- PERF:
-- HACK:
-- TODO:
-- NOTE:
-- FIX:
-- WARN:

-- Following are the default keybindings, you can overwrite them in the config
--[[
    menu_bindings = {
      { node = 'item', desc = '[L]ist terminals', shortcut = 'l', command = 'PioTermList' },
      { node = 'item', desc = '[T]erminal Core CLI', shortcut = 't', command = 'Piocmdf' },
      {
        node = 'menu',
        desc = '[G]eneral',
        shortcut = 'g',
        items = {
          { node = 'item', desc = '[B]uild', shortcut = 'b', command = 'Piocmdf run' },
          { node = 'item', desc = '[U]pload', shortcut = 'u', command = 'Piocmdf run -t upload' },
          { node = 'item', desc = '[M]onitor', shortcut = 'm', command = 'Piocmdh run -t monitor' },
          { node = 'item', desc = '[C]lean', shortcut = 'c', command = 'Piocmdf run -t clean' },
          { node = 'item', desc = '[F]ull clean', shortcut = 'f', command = 'Piocmdf run -t fullclean' },
          { node = 'item', desc = '[D]evice list', shortcut = 'd', command = 'Piocmdf device list' },
        },
      },
      {
        node = 'menu',
        desc = '[P]latform',
        shortcut = 'p',
        items = {
          { node = 'item', desc = '[B]uild file system', shortcut = 'b', command = 'Piocmdf run -t buildfs' },
          { node = 'item', desc = 'Program [S]ize', shortcut = 's', command = 'Piocmdf run -t size' },
          { node = 'item', desc = '[U]pload file system', shortcut = 'u', command = 'Piocmdf run -t uploadfs' },
          { node = 'item', desc = '[E]rase Flash', shortcut = 'e', command = 'Piocmdf run -t erase' },
        },
      },
      {
        node = 'menu',
        desc = '[D]ependencies',
        shortcut = 'd',
        items = {
          { node = 'item', desc = '[L]ist packages', shortcut = 'l', command = 'Piocmdf pkg list' },
          { node = 'item', desc = '[O]utdated packages', shortcut = 'o', command = 'Piocmdf pkg outdated' },
          { node = 'item', desc = '[U]pdate packages', shortcut = 'u', command = 'Piocmdf pkg update' },
        },
      },
      {
        node = 'menu',
        desc = '[A]dvanced',
        shortcut = 'a',
        items = {
          { node = 'item', desc = '[T]est', shortcut = 't', command = 'Piocmdf test' },
          { node = 'item', desc = '[C]heck', shortcut = 'c', command = 'Piocmdf check' },
          { node = 'item', desc = '[D]ebug', shortcut = 'd', command = 'Piocmdf debug' },
          { node = 'item', desc = 'Compilation Data[b]ase', shortcut = 'b', command = 'Piocmdf run -t compiledb' },
          {
            node = 'menu',
            desc = '[V]erbose',
            shortcut = 'v',
            items = {
              { node = 'item', desc = 'Verbose [B]uild', shortcut = 'b', command = 'Piocmdf run -v' },
              { node = 'item', desc = 'Verbose [U]pload', shortcut = 'u', command = 'Piocmdf run -v -t upload' },
              { node = 'item', desc = 'Verbose [T]est', shortcut = 't', command = 'Piocmdf test -v' },
              { node = 'item', desc = 'Verbose [C]heck', shortcut = 'c', command = 'Piocmdf check -v' },
              { node = 'item', desc = 'Verbose [D]ebug', shortcut = 'd', command = 'Piocmdf debug -v' },
            },
          },
        },
      },
      {
        node = 'menu',
        desc = '[R]emote',
        shortcut = 'r',
        items = {
          { node = 'item', desc = 'Remote [U]pload', shortcut = 'u', command = 'Piocmdf remote run -t upload' },
          { node = 'item', desc = 'Remote [T]est', shortcut = 't', command = 'Piocmdf remote test' },
          { node = 'item', desc = 'Remote [M]onitor', shortcut = 'm', command = 'Piocmdh remote run -t monitor' },
          { node = 'item', desc = 'Remote [D]evices', shortcut = 'd', command = 'Piocmdf remote device list' },
        },
      },
      {
        node = 'menu',
        desc = '[M]iscellaneous',
        shortcut = 'm',
        items = {
          { node = 'item', desc = '[U]pgrade PlatformIO Core', shortcut = 'u', command = 'Piocmdf upgrade' },
        },
      },
    },
    --]]
-- })
-- end
-- }, --opts {}
-- ,
-- }
