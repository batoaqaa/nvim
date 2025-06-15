return {
  'williamboman/mason-lspconfig.nvim',
  opts = {
    automatic_enable = false,
    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    automatic_installation = false,
  },
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        --     cmd = 'Mason',
        --     keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        --     build = ':MasonUpdate',
        --     opts_extend = { 'ensure_installed' },
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      },
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
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
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    require('custom.plugins.lsp-config.config')
  end,
}
