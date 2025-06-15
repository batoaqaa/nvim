-- return {
--   'williamboman/mason-lspconfig.nvim',
--   opts = {
--     automatic_enable = false,
--   },
--   dependencies = {
--     'WhoIsSethDaniel/mason-tool-installer.nvim',
--     dependencies = {
--       'williamboman/mason.nvim',
--       opts = {
--         ui = {
--           icons = {
--             package_installed = '✓',
--             package_pending = '➜',
--             package_uninstalled = '✗',
--           },
--         },
--       },
--     },
--     opts = {
--       -- list of formatter and linter for mason to install
--       -- opts_extend = { 'ensure_installed' },
--       ensure_installed = {
--         'arduino_language_server',
--         'astro',
--         'basedpyright',
--         'bashls',
--         'black',
--         'biome',
--         'clangd',
--         'cssls',
--         'clang-format',
--         'debugpy',
--         'dockerls',
--         'emmet_language_server',
--         'eslint',
--         'gopls',
--         'graphql',
--         'html',
--         'jsonls',
--         'lua_ls',
--         'isort',
--         'mdx_analyzer',
--         'mypy',
--         'prettier',
--         'prettierd',
--         'pylint',
--         'pyright',
--         'rust_analyzer',
--         'shfmt',
--         'stylua',
--         'svelte',
--         'terraformls',
--         'tailwindcss',
--         'ts_ls',
--         'yamlfmt',
--         'yamllint',
--         'yamlls',
--       },
--     },
--   },
--   config = function()
--     require('custom.plugins.lsp-config.config')
--   end,
-- }
return {
  { -- Start neovim/nvim-lspconfig
    'williamboman/mason-lspconfig.nvim',
    opts = {},
    dependencies = { --Start mason.nvim
      'williamboman/mason.nvim',
      cmd = 'Mason',
      keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
      build = ':MasonUpdate',
      opts_extend = { 'ensure_installed' },
      opts = {
        ensure_installed = {
          'black',
          'biome',
          'clang-format',
          'clangd',
          'isort',
          'prettier',
          'prettierd',
          'pyright',
          'shfmt',
          'lua-language-server',
          'stylua',
          'yamlfmt',
          'yamllint',
          -- 'lemminx',
          -- 'marksman',
          -- 'flake8',
          'debugpy',
          'debugpy',
          'isort',
          'mypy',
          'pylint',
        },
        PATH = 'append',
        ui = {
          border = 'single',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      },
      --@param opts MasonSettings | {ensure_installed: string[]}
      config = function(_, opts)
        require('mason').setup(opts)
        local mr = require('mason-registry')
        mr:on('package:install:success', function()
          vim.defer_fn(function()
            -- trigger FileType event to possibly load this newly installed LSP server
            require('lazy.core.handler.event').trigger({
              event = 'FileType',
              buf = vim.api.nvim_get_current_buf(),
            })
          end, 100)
        end)

        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end,
    }, -- End mason.nvim
    config = function()
      require('custom.plugins.lsp-config.config')
    end,
  }, -- End neovim/nvim-lspconfig
  -- {
  --   'folke/trouble.nvim',
  --   event = 'LspAttach',
  --   opts = {
  --     focus = true,
  --     auto_open = false,
  --     auto_jump = false,
  --     auto_refresh = false,
  --   },
  -- },
}
