---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = 'Enable',
        await = true,
        paramName = 'All',
        paramType = true,
        semicolon = 'Disable',
        setType = true,
      },
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } },
      runtime = {
        -- Specify LuaJIT for Neovim
        version = 'LuaJIT',
        -- Include Neovim runtime files
        path = vim.split(package.path, ';'),
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          './lua',
          vim.api.nvim_get_runtime_file('', true),
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/busted/library",
        },
      },
    },
  },
  -- on_init = function(client)
  --   if client.workspace_folders then
  --     local path = client.workspace_folders[1].name
  --     if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
  --       return
  --     end
  --   end
  --   local Lua = {
  --     hint = { enable = true },
  --     telemetry = { enable = false },
  --     diagnostics = { globals = { "vim" } },
  --     runtime = {
  --       version = 'LuaJIT',
  --     },
  --     workspace = {
  --       checkThirdParty = false,
  --       library = {
  --         vim.env.VIMRUNTIME,
  --         "${3rd}/luv/library",
  --         './lua',
  --         -- Depending on the usage, you might want to add additional paths here.
  --         -- "${3rd}/busted/library",
  --       }
  --     },
  --   }
  --   client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, Lua)
  -- end,
}
