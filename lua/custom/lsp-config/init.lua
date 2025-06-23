return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        config = function()
          require("custom.lsp-config.config")
        end,
      },
      {
        "folke/trouble.nvim",
        event = "LspAttach",
        opts = {
          focus = true,
          auto_open = false,
          auto_jump = false,
          auto_refresh = false,
        },
      },
      { "j-hui/fidget.nvim", opts = {} }, -- status bottom right
    },
  },
}
