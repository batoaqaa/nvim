--[[
This LSP setup from: https://github.com/edr3x/nvim
--]]
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. '/.luarc.json')
      end,
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'custom.plugins.lsp.handlers'
      require 'custom.plugins.lsp.config'
    end,
    dependencies = {
      'RRethy/vim-illuminate',
      {
        'williamboman/mason-lspconfig.nvim',
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
            local mr = require 'mason-registry'
            mr:on('package:install:success', function()
              vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                require('lazy.core.handler.event').trigger {
                  event = 'FileType',
                  buf = vim.api.nvim_get_current_buf(),
                }
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
        }, --End mason.nvim
      },
    },
  },
  {
    'folke/trouble.nvim',
    event = 'LspAttach',
    opts = {
      focus = true,
      auto_open = false,
      auto_jump = false,
      auto_refresh = false,
    },
  },
  -- Lsp notifications
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'p00f/clangd_extensions.nvim',
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = true,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = '',
        },
      },
    },
  },
}
