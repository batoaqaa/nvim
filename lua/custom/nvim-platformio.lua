return {

  -- 'batoaqaa/nvim-platformio.lua',
  'anurag3301/nvim-platformio.lua',
  -- cmd = { 'Pioinit', 'Piorun', 'Piocmdh', 'Piocmdf', 'Piolib', 'Piomon', 'Piodebug', 'Piodb' },

  -- dependencies are always lazy-loaded unless specified otherwise
  dependencies = {
    { 'akinsho/toggleterm.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-lua/plenary.nvim' },
    {
      -- WhichKey helps you remember your Neovim keymaps,
      -- by showing available keybindings in a popup as you type.
      'folke/which-key.nvim',
      opts = {
        preset = 'helix', --'modern', --"classic", --
        sort = { 'order', 'group', 'manual', 'mod' },
      },
    },
  },

  opts = {
    lsp = 'clangd', --default: ccls, other option: clangd
    -- If you pick clangd, it also creates compile_commands.json
    --
    --     menu_key = '<leader>p',
    --
  },
  -- config = function()
  --   require('platformio').setup({
  --     lsp = 'clangd', --default: ccls, other option: clangd
  --     -- If you pick clangd, it also creates compile_commands.json
  --   })
  --
  --   local icon = { icon = '  ', color = 'orange' }
  --   local ok, wk = pcall(require, 'which-key') --will also load the package if it isn't loaded already
  --   if not ok then
  --     vim.api.nvim_echo({
  --       { 'which-key plugin not found!', 'ErrorMsg' },
  --     }, true, {})
  --   else
  --     local prefix = '<leader>p' -- or use 'gp'
  --     local Piocmd = 'Piocmdf'   -- 'Piocmdh' (horizontal terminal)  'Piocmdf' (float terminal)
  --     wk.add({
  --       { prefix,         group = '[P]latformIO:',   icon = icon },
  --       -- { prefix, group = 'PlatformIO:', icon = icon },
  --       { prefix .. 'g',  group = '[g]eneral',       icon = icon },
  --       { prefix .. 'd',  group = '[d]ependencies',  icon = icon },
  --       { prefix .. 'a',  group = '[a]dvance',       icon = icon },
  --       { prefix .. 'av', group = '[v]erbose',       icon = icon },
  --       { prefix .. 'r',  group = '[r]emote',        icon = icon },
  --       { prefix .. 'm',  group = '[m]iscellaneous', icon = icon },
  --       {
  --         mode = { 'n' }, -- NORMAL and VISUAL mode
  --         { prefix .. 'l',   '<cmd>' .. 'PioTermList' .. ' <CR>',            desc = '[l]ist terminals',         icon = icon },
  --         { prefix .. 'gb',  '<cmd>' .. Piocmd .. ' run<CR>',                desc = '[b]uild',                  icon = icon },
  --         { prefix .. 'gc',  '<cmd>' .. Piocmd .. ' run -t clean<CR>',       desc = '[c]lean',                  icon = icon },
  --         { prefix .. 'gf',  '<cmd>' .. Piocmd .. ' run -t fullclean<CR>',   desc = '[f]ull clean',             icon = icon },
  --         { prefix .. 'gd',  '<cmd>' .. Piocmd .. ' device list<CR>',        desc = '[d]evice list',            icon = icon },
  --         -- { prefix .. 'gm', '<cmd>' .. Piocmd .. ' run -t monitor<CR>', desc = '[m]onitor', icon = icon   },
  --         { prefix .. 'gm',  '<cmd>' .. 'Piocmdh' .. ' run -t monitor<CR>',  desc = '[m]onitor',                icon = icon },
  --         { prefix .. 'gu',  '<cmd>' .. Piocmd .. ' run -t upload<CR>',      desc = '[u]pload',                 icon = icon },
  --         { prefix .. 'gs',  '<cmd>' .. Piocmd .. ' run -t uploadfs<CR>',    desc = 'upload file [s]ystem',     icon = icon },
  --         { prefix .. 'gt',  '<cmd>' .. Piocmd .. '<CR>',                    desc = 'Core CLI [T]erminal',      icon = icon },
  --
  --         { prefix .. 'dl',  '<cmd>' .. Piocmd .. ' pkg list<CR>',           desc = '[l]ist packages',          icon = icon },
  --         { prefix .. 'do',  '<cmd>' .. Piocmd .. ' pkg outdated<CR>',       desc = 'List [o]utdated packages', icon = icon },
  --         { prefix .. 'du',  '<cmd>' .. Piocmd .. ' pkg update<CR>',         desc = '[u]pdate packages',        icon = icon },
  --
  --         { prefix .. 'at',  '<cmd>' .. Piocmd .. ' test<CR>',               desc = '[t]est',                   icon = icon },
  --         { prefix .. 'ac',  '<cmd>' .. Piocmd .. ' check<CR>',              desc = '[c]heck',                  icon = icon },
  --         { prefix .. 'ad',  '<cmd>' .. Piocmd .. ' debug<CR>',              desc = '[d]ebug',                  icon = icon },
  --         { prefix .. 'ab',  '<cmd>' .. Piocmd .. ' run -t compiledb<CR>',   desc = 'compilation data[b]ase',   icon = icon },
  --
  --         { prefix .. 'avb', '<cmd>' .. Piocmd .. ' run -v<CR>',             desc = '[b]uild',                  icon = icon },
  --         { prefix .. 'avd', '<cmd>' .. Piocmd .. ' debug -v<CR>',           desc = '[d]ebug',                  icon = icon },
  --         { prefix .. 'avu', '<cmd>' .. Piocmd .. ' run -v -t upload<CR>',   desc = '[u]pload',                 icon = icon },
  --         { prefix .. 'avs', '<cmd>' .. Piocmd .. ' run -v -t uploadfs<CR>', desc = 'upload file [s]ystem',     icon = icon },
  --         { prefix .. 'avt', '<cmd>' .. Piocmd .. ' test -v<CR>',            desc = '[t]est',                   icon = icon },
  --         { prefix .. 'avc', '<cmd>' .. Piocmd .. ' check -v<CR>',           desc = '[c]heck',                  icon = icon },
  --         {
  --           prefix .. 'ava',
  --           '<cmd>' .. Piocmd .. ' run -v -t compiledb<CR>',
  --           desc = 'compilation databa[a]e',
  --           icon = icon,
  --         },
  --
  --         { prefix .. 'ru', '<cmd>' .. Piocmd .. ' remote run -t upload<CR>',     desc = '[u]pload',      icon = icon },
  --         { prefix .. 'rt', '<cmd>' .. Piocmd .. ' remote test<CR>',              desc = '[t]est',        icon = icon },
  --         { prefix .. 'rm', '<cmd>' .. 'Piocmdh' .. ' remote run -t monitor<CR>', desc = '[m]onitor',     icon = icon },
  --         { prefix .. 'rd', '<cmd>' .. Piocmd .. ' remote device list<CR>',       desc = '[d]evice list', icon = icon },
  --
  --         { prefix .. 'mu', '<cmd>' .. Piocmd .. ' upgrade<CR>',                  desc = '[u]pgrade',     icon = icon },
  --       },
  --     })
  --   end
  -- end,
}
