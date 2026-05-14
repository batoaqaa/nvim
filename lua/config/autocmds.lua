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

vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})


-- AUTO-CLEANUP ON EXIT
-- SELECTIVE CLEANUP ON EXIT (Keeps plugins, deletes temp files)
-- stylua: ignore
-- SELECTIVE CLEANUP FOR WINDOWS
--vim.api.nvim_create_autocmd("VimLeavePre", { -- Use VimLeavePre to act before the write attempt
--  callback = function()
--    -- 1. Tell Neovim NOT to write the history file on exit to avoid E138
--    vim.opt.shadafile = "NONE"
--
--    -- 2. Define target paths
--    local state_path = vim.fn.stdpath("state")
--    local cache_path = vim.fn.stdpath("cache")
--
--    local targets = {
--      state_path .. "/shada",
--      cache_path,
--    }
--
--    -- 3. Delete the directories cross-platform
--    for _, path in ipairs(targets) do
--      if vim.fn.isdirectory(path) == 1 then
--        -- Native Neovim function (0.9+) that handles Windows/macOS/Linux paths automatically
--        vim.fs.rm(path, { recursive = true, force = true })
--      end
--    end
--  end,
--})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.opt.shadafile = "NONE"

    local state_path = vim.fn.stdpath("state")
    local cache_path = vim.fn.stdpath("cache")

    -- 1. Wipe Shada (History)
    local shada_dir = state_path .. "/shada"
    if vim.fn.isdirectory(shada_dir) == 1 then
      vim.fs.rm(shada_dir, { recursive = true, force = true })
    end

    -- 2. Wipe Cache safely
    -- We delete contents of cache but avoid deleting the root 'luac' 
    -- folder immediately to prevent the 'vim/loader.lua' crash.
    if vim.fn.isdirectory(cache_path) == 1 then
      for name, type in vim.fs.dir(cache_path) do
        if name ~= "luac" then -- Skip the compiled bytecode folder
          vim.fs.rm(cache_path .. "/" .. name, { recursive = true, force = true })
        end
      end
    end
  end,
})

-- In your init.lua or a loaded config file

-- vim.api.nvim_create_autocmd('ModeChanged', {
--   pattern = { '*:i*', 'i*:*' },
--   group = vim.api.nvim_create_augroup('EnableDisableRelativenumber', {clear = true}),
--   callback = function()
--     vim.o.relativenumber = vim.api.nvim_get_mode().mode:match('^i') == nil
--   end,
-- })
------------------------

-- vim.api.nvim_create_user_command('PPPioEnable', function() --available only if no platformio.ini in cwd
--   vim.g.platformioRootDir = vim.fn.getcwd()
--   vim.notify('PlatformIO enable start ...', vim.log.levels.INFO, { title = 'PlatformIO' })
--   local LazyUserEvents_group = vim.api.nvim_create_augroup('LazyUserEvents', { clear = true })
--   -- print(vim.inspect(require('lazy').stats()))
--   -- print(vim.inspect(require('lazy.core.config').plugins['nvim-platformio.lua']))
--   -- print(vim.inspect(require('lazy.core.config').plugins))
--   -- print(vim.inspect(require('lazy.core.config').spec))
--   --
--   -- Access lazy's internal data to see if the plugin is already set up
--   -- local platformio_plugin = require('lazy.core.config').plugins['nvim-platformio.lua']
--   -- -- Check if the plugin exists and is not installed
--   -- if platformio_plugin and not platformio_plugin.specs then -- is_installed then
--   --   vim.notify('PlatformIO project detected. Installing nvim-platformio...', vim.log.levels.INFO)
--   -- end
--
--   -- if not ( require('lazy.core.config').spec.disabled['nvim-platformio.lua'] or require('lazy.core.config').spec.ignore_installed['nvim-platformio.lua']) then
--   -- if require('lazy.core.config').spec.disabled['nvim-platformio.lua'] then
--   --   print('here ...')
--   -- end
--   -- require("lazy").add .add_spec("github-username/repository-name")
--   -- require('lazy').check({ show = false })
--   -- Trigger after LazySync
--   -- require('lazy').install({ plugins = { 'batoaqaa/nvim-platformio.lua' }, show = false })
--   -- require('lazy').install({ show = false, plugins = { 'nvim-platformio.lua' } })
--   -- require('lazy').install({ show = false })
--   -- vim.cmd("Lazy install show=false")
--   -- require('lazy').restore({ show = false })
--   -- Check if the plugin is already defined in lazy's internal config
--   -- require('lazy').restore({ show = false })
--   -- if (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
--   -- require('lazy').sync({ show = false })
--   --   -- else
--   --   --   require('lazy').restore({ show = false })
--   --   vim.defer_fn(function()
--   --     require('lazy').sync({ show = false })
--   --     -- require('lazy').restore({ show = false })
--   --   end, 0)
--   -- end
--
--   vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--     pattern = 'LazyInstall',
--     once = true,
--     group = LazyUserEvents_group,
--     callback = function(args)
--       vim.notify('PlatformIO installed', vim.log.levels.INFO, { title = 'PlatformIO' })
--       require('lazy').sync({ show = false })
--     end,
--   })
--
--   vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--     pattern = 'LazyInstallPre',
--     once = true,
--     group = LazyUserEvents_group,
--     callback = function(args)
--       vim.notify('PlatformIO installpre', vim.log.levels.INFO, { title = 'PlatformIO' })
--     end,
--   })
--
--   vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--     pattern = 'LazySync',
--     once = true,
--     group = LazyUserEvents_group,
--     callback = function(args)
--       vim.notify('PlatformIO synced', vim.log.levels.INFO, { title = 'PlatformIO' })
--       require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
--     end,
--   })
--
--   vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--     pattern = 'LazyRestore',
--     once = true,
--     group = LazyUserEvents_group,
--     callback = function(args)
--       vim.notify('PlatformIO restored', vim.log.levels.INFO, { title = 'PlatformIO' })
--       require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
--     end,
--   })
--
--   vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--     pattern = 'LazyLoad',
--     once = true,
--     group = LazyUserEvents_group,
--     callback = function(args)
--       vim.notify('PlatformIO enable complete!', vim.log.levels.INFO, { title = 'PlatformIO' })
--     end,
--   })
--
--   if (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
--       require('lazy').sync({ show = false, wait = true })
--   end
--
--   -- vim.api.nvim_create_autocmd('User', { -- if enabled then load platformio plugin
--   --   pattern = { 'LazyLoad', 'LazyRestore' },
--   --   once = true,
--   --   callback = function(args)
--   --   end,
--   -- })
--   --
-- end, {})
