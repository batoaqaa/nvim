local autogroup = vim.api.nvim_create_augroup
local sussmanGroup = autogroup('DMS', {})
local autocmd = vim.api.nvim_create_autocmd
-- resize splits if the window itself is resized
autocmd('VimResized', {
  group = sussmanGroup,
  callback = function()
    local currentTab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. currentTab)
  end,
})

autocmd({
  'BufEnter',
  'FocusGained',
  'InsertLeave',
  'CmdlineLeave',
  'WinEnter',
}, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('EnableRelativenumber', { clear = true }),
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
  desc = 'Enable relative number in normal mode',
})

autocmd({
  'BufLeave',
  'FocusLost',
  'InsertEnter',
  'CmdlineEnter',
  'WinLeave',
}, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('DisableRelativenumber', { clear = true }),
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd('redraw')
    end
  end,
  desc = 'Disable relative number in insert mode',
})
-- In your init.lua or a loaded config file

-- vim.g.enable_toggle_me_plugin = true -- Default to enabled, or false if you want it off by default
vim.api.nvim_create_user_command('EnablePlatformio', function()
  -- Check if the plugin is already loaded to avoid re-running config
  vim.notify('Enabling nvim-platformio.lua ...', vim.log.levels.INFO)
  require('lazy').sync({ show = false })
  -- vim.cmd('Lazy sync')
  require('lazy').load({ plugins = { 'nvim-platformio.lua' } })

  -- require('lazy.core.loader').reload(require('lazy.core.config').plugins['nvim-platformio.lua'])
  dofile(vim.env.MYVIMRC)
end, {
  desc = 'Load and open the trouble.nvim plugin',
})
--
vim.api.nvim_create_user_command('ReloadPlugin', function()
  -- vim.g.enable_toggle_me_plugin = not vim.g.enable_toggle_me_plugin
  print("Toggling 'toggle-me-plugin' to: " .. (vim.g.enable_toggle_me_plugin and 'enabled' or 'disabled'))

  -- Crucially, reload lazy.nvim to apply the change
  require('lazy').reload()

  -- You might want to also re-source your init.lua if the global variable
  -- is set there, to ensure it's picked up before the Lazy reload.
  -- :source $MYVIMCONFIG/init.lua
end, {
  desc = 'Toggle the "toggle-me-plugin" on/off and reload lazy.nvim',
})

-- vim.api.nvim_create_autocmd('ModeChanged', {
--   pattern = { '*:i*', 'i*:*' },
--   group = vim.api.nvim_create_augroup('EnableDisableRelativenumber', {clear = true}),
--   callback = function()
--     vim.o.relativenumber = vim.api.nvim_get_mode().mode:match('^i') == nil
--   end,
-- })
------------------------

-- vim.api.nvim_create_user_command('PioToggle', function()
--   vim.notify('PlatformIO Starting ...', vim.log.levels.INFO, { title = 'PlatformIO' })
--   require('lazy').sync({ show = false })
--   -- The 'LazySync' event is fired when the sync is complete
--   vim.api.nvim_create_autocmd('User', {
--     pattern = 'LazySync',
--     once = true,
--     callback = function()
--       vim.defer_fn(function()
--         require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
--       end, 0)
--       vim.notify('PlatformIO Start complete!', vim.log.levels.INFO, { title = 'PlatformIO' })
--     end,
--   })
-- end, {
--   desc = 'Sync lazy.nvim plugins without showing the UI',
-- })

-- vim.g.platformioEnabled = true
vim.api.nvim_create_user_command('PioEnable', function() --available only if no platformio.ini in cwd
  vim.g.platformioRootDir = vim.fn.getcwd()
  vim.notify('PlatformIO enable start ...', vim.log.levels.INFO, { title = 'PlatformIO' })
  local LazyUserEvents_group = vim.api.nvim_create_augroup('LazyUserEvents', { clear = true })

  -- Access lazy's internal data to see if the plugin is already set up
  local platformio_plugin = require('lazy.core.config').plugins['nvim-platformio.lua']
  print(vim.inspect(require('lazy.core.config').plugins))
  -- Check if the plugin exists and is not installed
  if platformio_plugin and not platformio_plugin.specs then -- is_installed then
    vim.notify('PlatformIO project detected. Installing nvim-platformio...', vim.log.levels.INFO)
  end
  -- Trigger after LazySync
  -- require('lazy').install({ plugins = { 'batoaqaa/nvim-platformio.lua' }, show = false })
  -- require('lazy').install({ plugins = { 'nvim-platformio.lua' }, show = false })
  -- vim.cmd("Lazy install show=false")
  -- require('lazy').restore({ show = false })
  -- Check if the plugin is already defined in lazy's internal config
  -- require('lazy').restore({ show = false })
  -- if (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
  --   -- require('lazy').sync({ show = false })
  --   -- else
  --   --   require('lazy').restore({ show = false })
  --   vim.defer_fn(function()
  --     require('lazy').sync({ show = false })
  --     -- require('lazy').restore({ show = false })
  --   end, 0)
  -- end

  vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
    pattern = 'LazyInstall',
    once = true,
    group = LazyUserEvents_group,
    callback = function(args)
      print(args.match)
      -- print(args.file)
      -- print(vim.inspect(args.data))
      vim.notify('PlatformIO installed', vim.log.levels.INFO, { title = 'PlatformIO' })
      -- require('lazy').install({ show = false })
      -- vim.defer_fn(function()
      require('lazy').sync({ show = false })
      --   -- require('lazy').restore({ show = false })
      -- end, 0)
    end,
  })
  vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
    pattern = 'LazySync',
    once = true,
    group = LazyUserEvents_group,
    callback = function(args)
      print(args.match)
      -- print(args.file)
      -- print(vim.inspect(args.data))
      vim.notify('PlatformIO synced', vim.log.levels.INFO, { title = 'PlatformIO' })
      -- require('lazy').install({ show = false })
      require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
      -- require('lazy').restore({ show = false })
      -- require('lazy').restore({ show = false })
    end,
  })
  vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
    pattern = 'LazyRestore',
    once = true,
    group = LazyUserEvents_group,
    callback = function(args)
      print(args.match)
      -- print(args.file)
      -- print(vim.inspect(args.data))
      vim.notify('PlatformIO restored', vim.log.levels.INFO, { title = 'PlatformIO' })
      require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
    end,
  })
  vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
    pattern = 'LazyLoad',
    once = true,
    group = LazyUserEvents_group,
    callback = function(args)
      print(args.match)
      -- print(args.file)
      -- print(vim.inspect(args.data))
      vim.notify('PlatformIO enable complete!', vim.log.levels.INFO, { title = 'PlatformIO' })
      -- vim.api.nvim_command('Pioinit')
    end,
  })

  -- Check if the plugin is already defined in lazy's internal config
  -- require('lazy').restore({ show = false })
  if (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
    -- require('lazy').sync({ show = false })
    -- else
    --   require('lazy').restore({ show = false })
    vim.defer_fn(function()
      require('lazy').sync({ show = false })
      -- require('lazy').restore({ show = false })
    end, 0)
  end

  -- vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
  --   pattern = { 'LazyLoad', 'LazyRestore' },
  --   once = true,
  --   callback = function(args)
  --     if args.match == 'LazyRestore' then
  --       vim.notify('PlatformIO restored', vim.log.levels.INFO, { title = 'PlatformIO' })
  --       require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
  --     elseif args.match == 'LazyLoad' then
  --       vim.notify('PlatformIO enable complete!', vim.log.levels.INFO, { title = 'PlatformIO' })
  --       print('Data:', args.data)
  --       -- vim.api.nvim_command('Pioinit')
  --     end
  --   end,
  -- })
  --
end, {})
