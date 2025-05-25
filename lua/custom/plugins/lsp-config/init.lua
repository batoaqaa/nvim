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
          'isort',
          'prettier',
          'prettierd',
          'pyright',
          'shfmt',
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
