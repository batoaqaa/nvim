return {
  'batoaqaa/nvim-platformio.lua',
  -- 'anurag3301/nvim-platformio.lua',
  --
  -- cmd = { 'Pioinit', 'Piorun', 'Piocmdh', 'Piocmdf', 'Piolib', 'Piomon', 'Piodebug', 'Piodb' },
  -- lazy = vim.g.platformioRootDir ~= nil,
  -- event = 'User PioLoad',

  -- optional: cond used to enable/disable platformio
  -- based on existance of platformio.ini file and .pio folder in cwd.
  -- You can enable platformio plugin, using :Pioinit command
  cond = function()
    -- local platformioRootDir = vim.fs.root(vim.fn.getcwd(), { 'platformio.ini' }) -- cwd and parents
    local platformioRootDir = (vim.fn.filereadable('platformio.ini') == 1) and vim.fn.getcwd() or nil
    if platformioRootDir and vim.fs.find('.pio', { path = platformioRootDir, type = 'directory' })[1] then
      -- if platformio.ini file and .pio folder exist in cwd, enable plugin to install plugin (if not istalled) and load it.
      vim.g.platformioRootDir = platformioRootDir
    elseif (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
      -- if nvim-platformio not installed, enable plugin to install it first time
      vim.g.platformioRootDir = vim.fn.getcwd()
    else                                                     -- if nvim-platformio.lua installed but disabled, create Pioinit command
      vim.api.nvim_create_user_command('Pioinit', function() --available only if no platformio.ini and .pio in cwd
        vim.api.nvim_create_autocmd('User', {
          pattern = { 'LazyRestore', 'LazyLoad' },
          once = true,
          callback = function(args)
            if args.match == 'LazyRestore' then
              require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
            elseif args.match == 'LazyLoad' then
              vim.notify('PlatformIO loaded', vim.log.levels.INFO, { title = 'PlatformIO' })
              vim.cmd('Pioinit')
            end
          end,
        })
        vim.g.platformioRootDir = vim.fn.getcwd()
        require('lazy').restore({ plguins = { 'nvim-platformio.lua' }, show = false })
      end, {})
    end
    return vim.g.platformioRootDir ~= nil
  end,

  -- vim.api.nvim_exec_autocmds('User', {
  --     pattern = 'MyCustomEvent',
  --     data = 'Hello from the data attribute!', -- This value goes into args.data
  --     -- You can also specify a buffer or other options here
  --     -- buf = vim.api.nvim_get_current_buf(),
  -- })
  dependencies = {
    { 'akinsho/toggleterm.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'folke/which-key.nvim' },
  },
  opts = {
    -- config = function()
    --   local pok, platformio = pcall(require, 'platformio')
    --   if pok then
    --     platformio.setup({
    lsp = 'clangd', --default: ccls, other option: clangd
    -- If you pick clangd, it also creates compile_commands.json

    -- Uncomment out following line to enable platformio menu.
    menu_key = '<leader>\\',  -- replace this menu key  to your convenience
    menu_name = 'PlatformIO', -- replace this menu name to your convenience

    -- Following are the default keybindings, you can overwrite them in the config
    --[[
          menu_bindings = {
            { node = 'item', desc = '[L]ist terminals',    shortcut = 'l', command = 'PioTermList' },
            { node = 'item', desc = '[T]erminal Core CLI', shortcut = 't', command = 'Piocmdf' },
            {
              node = 'menu',
              desc = '[G]eneral',
              shortcut = 'g',
              items = {
                { node = 'item', desc = '[B]uild',       shortcut = 'b', command = 'Piocmdf run' },
                { node = 'item', desc = '[U]pload',      shortcut = 'u', command = 'Piocmdf run -t upload' },
                { node = 'item', desc = '[M]onitor',     shortcut = 'm', command = 'Piocmdh run -t monitor' },
                { node = 'item', desc = '[C]lean',       shortcut = 'c', command = 'Piocmdf run -t clean' },
                { node = 'item', desc = '[F]ull clean',  shortcut = 'f', command = 'Piocmdf run -t fullclean' },
                { node = 'item', desc = '[D]evice list', shortcut = 'd', command = 'Piocmdf device list' },
              },
            },
            {
              node = 'menu',
              desc = '[P]latform',
              shortcut = 'p',
              items = {
                { node = 'item', desc = '[B]uild file system',  shortcut = 'b', command = 'Piocmdf run -t buildfs' },
                { node = 'item', desc = 'Program [S]ize',       shortcut = 's', command = 'Piocmdf run -t size' },
                { node = 'item', desc = '[U]pload file system', shortcut = 'u', command = 'Piocmdf run -t uploadfs' },
                { node = 'item', desc = '[E]rase Flash',        shortcut = 'e', command = 'Piocmdf run -t erase' },
              },
            },
            {
              node = 'menu',
              desc = '[D]ependencies',
              shortcut = 'd',
              items = {
                { node = 'item', desc = '[L]ist packages',     shortcut = 'l', command = 'Piocmdf pkg list' },
                { node = 'item', desc = '[O]utdated packages', shortcut = 'o', command = 'Piocmdf pkg outdated' },
                { node = 'item', desc = '[U]pdate packages',   shortcut = 'u', command = 'Piocmdf pkg update' },
              },
            },
            {
              node = 'menu',
              desc = '[A]dvanced',
              shortcut = 'a',
              items = {
                { node = 'item', desc = '[T]est',                 shortcut = 't', command = 'Piocmdf test' },
                { node = 'item', desc = '[C]heck',                shortcut = 'c', command = 'Piocmdf check' },
                { node = 'item', desc = '[D]ebug',                shortcut = 'd', command = 'Piocmdf debug' },
                { node = 'item', desc = 'Compilation Data[b]ase', shortcut = 'b', command = 'Piocmdf run -t compiledb' },
                {
                  node = 'menu',
                  desc = '[V]erbose',
                  shortcut = 'v',
                  items = {
                    { node = 'item', desc = 'Verbose [B]uild',  shortcut = 'b', command = 'Piocmdf run -v' },
                    { node = 'item', desc = 'Verbose [U]pload', shortcut = 'u', command = 'Piocmdf run -v -t upload' },
                    { node = 'item', desc = 'Verbose [T]est',   shortcut = 't', command = 'Piocmdf test -v' },
                    { node = 'item', desc = 'Verbose [C]heck',  shortcut = 'c', command = 'Piocmdf check -v' },
                    { node = 'item', desc = 'Verbose [D]ebug',  shortcut = 'd', command = 'Piocmdf debug -v' },
                  },
                },
              },
            },
            {
              node = 'menu',
              desc = '[R]emote',
              shortcut = 'r',
              items = {
                { node = 'item', desc = 'Remote [U]pload',  shortcut = 'u', command = 'Piocmdf remote run -t upload' },
                { node = 'item', desc = 'Remote [T]est',    shortcut = 't', command = 'Piocmdf remote test' },
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
          ]]
    --     })
    --   end
    -- end,
  },
}
