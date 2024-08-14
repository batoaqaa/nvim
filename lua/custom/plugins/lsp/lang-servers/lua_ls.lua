local opts = require 'custom.plugins.lsp.opts'
local local_cap = opts.capabilities
local_cap.offsetEncoding = { 'utf-8', 'utf-16' }

return {
  capabilities = local_cap,
  on_attach = opts.on_attach,
  settings = {
    Lua = {},
  },
  on_new_config = function(config)
    local uv = vim.uv or vim.loop
    local path = vim.fn.getcwd()
    -- Don't do anything if there is a project local config
    if uv.fs_stat(path .. '/.luarc.json') or uv.fs_stat(path .. '/.luarc.jsonc') then
      return
    end
    config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
      Lua = {
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = 'Replace',
          keywordSnippet = 'Replace',
          showWord = 'Disable', -- don't suggest common words as fallback
          postfix = '.',        -- useful for `table.insert` and the like
        },
        diagnostics = {
          globals = { 'vim' },            -- when contributing to nvim plugins missing a `.luarc.json`
          disable = { 'trailing-space' }, -- formatter already does that
        },
        doc = {
          privateName = { '^_' },
        },
        hint = {
          await = true,
          enable = true,
          arrayIndex = 'Auto',
          paramName = 'All',
          setType = false,
          paramType = true,
          semicolon = 'SameLine',
        },
        runtime = {
          version = 'LuaJIT',
        },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
            './lua',
          },
        },
      },
    })
  end,
}
