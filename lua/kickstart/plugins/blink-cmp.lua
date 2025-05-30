return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'normal',
    },
    signature = { enabled = true },

    completion = {
      -- documentation = {
      --   auto_show = true,
      -- },
      list = {
        selection = {
          preselect = true,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
