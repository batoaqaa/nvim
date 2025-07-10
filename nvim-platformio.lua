return {

  'batoaqaa/nvim-platformio.lua',
  -- 'anurag3301/nvim-platformio.lua',
  -- cmd = { 'Pioinit', 'Piorun', 'Piocmdh', 'Piocmdf', 'Piolib', 'Piomon', 'Piodebug', 'Piodb' },

  -- to use cond; first time you create project folder, you should create empty platformio.ini file
  cond = function() -- start/load nvim-platformio when platformio.ini file exist in cwd
    return true
    -- return vim.fn.filereadable('platformio.ini') == 1
    -- vim.api.nvim_create_autocmd('CmdUndefined', {
    --   pattern = 'Piocmdf',
    --   group = vim.api.nvim_create_augroup('LazyOrCond', { clear = true }),
    --   callback = function()
    --     -- When the command is run, load the plugin
    --     require('lazy').load({ plugins = { 'nvim-platformio.lua' }, wait = true })
    --     -- require('lazy.core.config').plugins['nvim-platformio.lua']._.enabled = true
    --     require('lazy.core.config').plugins['nvim-platformio.lua']._.disabled = false
    --     print('test')
    --     -- It's good practice to then run the command again
    --     -- vim.cmd('Piocmdf')
    --   end,
    -- })
  end,

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

  config = function()
    require('platformio').setup({
      lsp = 'clangd', --default: ccls, other option: clangd
      -- If you pick clangd, it also creates compile_commands.json

      -- Comment out following line to disable the default platformio key mappings.
      menu_key = '<leader>\\', -- replace this key mapping to your convenience
    })

    local prefix = require('platformio').config.menu_key or '<leader>\\'
    local ok, wk = pcall(require, 'which-key') --will also load the package if it isn't loaded already
    if not ok then
      vim.api.nvim_echo({
        { 'which-key plugin not found!', 'ErrorMsg' },
      }, true, {})
    else
      local icon = { icon = '  ', color = 'orange' }
      local Piocmd = 'Piocmdf' -- 'Piocmdh' (horizontal terminal)  'Piocmdf' (float terminal)
      wk.add({
        mode = { 'n', 'v' },   -- NORMAL and VISUAL mode
        { prefix,          group = '[P]latformIO:',                              icon = icon },

        -- { prefix .. 'g', hidden = true}, -- delete group
        { prefix .. 'g',   group = '[G]eneral',                                  icon = icon },
        { prefix .. 'gb',  '<cmd>' .. Piocmd .. ' run<CR>',                      desc = '[B]uild',                   icon = icon },
        { prefix .. 'gu',  '<cmd>' .. Piocmd .. ' run -t upload<CR>',            desc = '[U]pload',                  icon = icon },
        -- { prefix .. 'gm', '<Nop>', hidden = true }, -- delete keymapping
        { prefix .. 'gm',  '<cmd>' .. 'Piocmdh' .. ' run -t monitor<CR>',        desc = '[M]onitor',                 icon = icon },
        { prefix .. 'gc',  '<cmd>' .. Piocmd .. ' run -t clean<CR>',             desc = '[C]lean',                   icon = icon },
        { prefix .. 'gf',  '<cmd>' .. Piocmd .. ' run -t fullclean<CR>',         desc = '[F]ull clean',              icon = icon },
        { prefix .. 'gd',  '<cmd>' .. Piocmd .. ' device list<CR>',              desc = '[D]evice list',             icon = icon },

        { prefix .. 'p',   group = '[P]latform',                                 icon = icon },
        { prefix .. 'pb',  '<cmd>' .. Piocmd .. ' run -t buildfs<CR>',           desc = '[B]uild file system',       icon = icon },
        { prefix .. 'ps',  '<cmd>' .. Piocmd .. ' run -t size<CR>',              desc = 'Program [S]ize',            icon = icon },
        { prefix .. 'pu',  '<cmd>' .. Piocmd .. ' run -t uploadfs<CR>',          desc = '[U]pload file system',      icon = icon },
        { prefix .. 'pe',  '<cmd>' .. Piocmd .. ' run -t erase<CR>',             desc = '[E]rase Flash',             icon = icon },
        { prefix .. 'pi',  '<cmd>Pioinit<CR>',                                   desc = '[I]nit project',            icon = icon },

        { prefix .. 'd',   group = '[D]ependencies',                             icon = icon },
        { prefix .. 'dl',  '<cmd>' .. Piocmd .. ' pkg list<CR>',                 desc = '[L]ist packages',           icon = icon },
        { prefix .. 'do',  '<cmd>' .. Piocmd .. ' pkg outdated<CR>',             desc = '[O]utdated packages',       icon = icon },
        { prefix .. 'du',  '<cmd>' .. Piocmd .. ' pkg update<CR>',               desc = '[U]pdate packages',         icon = icon },

        { prefix .. 'a',   group = '[A]dvanced',                                 icon = icon },
        { prefix .. 'at',  '<cmd>' .. Piocmd .. ' test<CR>',                     desc = '[T]est',                    icon = icon },
        { prefix .. 'ac',  '<cmd>' .. Piocmd .. ' check<CR>',                    desc = '[C]heck',                   icon = icon },
        { prefix .. 'ad',  '<cmd>' .. Piocmd .. ' debug<CR>',                    desc = '[D]ebug',                   icon = icon },
        { prefix .. 'ab',  '<cmd>' .. Piocmd .. ' run -t compiledb<CR>',         desc = 'Compilation Data[b]ase',    icon = icon },

        { prefix .. 'av',  group = '[V]erbose',                                  icon = icon },
        { prefix .. 'avb', '<cmd>' .. Piocmd .. ' run -v<CR>',                   desc = 'Verbose [B]uild',           icon = icon },
        { prefix .. 'avu', '<cmd>' .. Piocmd .. ' run -v -t upload<CR>',         desc = 'Verbose [U]pload',          icon = icon },
        { prefix .. 'avt', '<cmd>' .. Piocmd .. ' test -v<CR>',                  desc = 'Verbose [T]est',            icon = icon },
        { prefix .. 'avc', '<cmd>' .. Piocmd .. ' check -v<CR>',                 desc = 'Verbose [C]heck',           icon = icon },
        { prefix .. 'avd', '<cmd>' .. Piocmd .. ' debug -v<CR>',                 desc = 'Verbose [D]ebug',           icon = icon },

        { prefix .. 'r',   group = '[R]emote',                                   icon = icon },
        { prefix .. 'ru',  '<cmd>' .. Piocmd .. ' remote run -t upload<CR>',     desc = 'Remote [U]pload',           icon = icon },
        { prefix .. 'rt',  '<cmd>' .. Piocmd .. ' remote test<CR>',              desc = 'Remote [T]est',             icon = icon },
        { prefix .. 'rm',  '<cmd>' .. 'Piocmdh' .. ' remote run -t monitor<CR>', desc = 'Remote [M]onitor',          icon = icon },
        { prefix .. 'rd',  '<cmd>' .. Piocmd .. ' remote device list<CR>',       desc = 'Remote [D]evices',          icon = icon },

        { prefix .. 'm',   group = '[M]iscellaneous',                            icon = icon },
        { prefix .. 'mu',  '<cmd>' .. Piocmd .. ' upgrade<CR>',                  desc = '[U]pgrade PlatformIO Core', icon = icon },

        { prefix .. 'l',   '<cmd>' .. 'PioTermList' .. ' <CR>',                  desc = '[L]ist terminals',          icon = icon },
        -- { prefix .. 'l', '<Nop>', hidden = true }, -- to delete which-key mapping
        { prefix .. 't',   '<cmd>' .. Piocmd .. '<CR>',                          desc = '[T]erminal Core CLI',       icon = icon },
      })
    end
  end,
}
