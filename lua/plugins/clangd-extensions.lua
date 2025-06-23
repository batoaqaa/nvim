return {
  'p00f/clangd_extensions.nvim',
  -- --lazy = true,
  config = function() end,
  opts = {
    ast = {
      -- These are unicode, should be available in any font
      role_icons = {
        type = '🄣',
        declaration = '🄓',
        expression = '🄔',
        statement = ';',
        specifier = '🄢',
        ['template argument'] = '🆃',
      },
      kind_icons = {
        Compound = '🄲',
        Recovery = '🅁',
        TranslationUnit = '🅄',
        PackExpansion = '🄿',
        TemplateTypeParm = '🅃',
        TemplateTemplateParm = '🅃',
        TemplateParamObject = '🅃',
      },
      highlights = {
        detail = 'Comment',
      },
    },
    memory_usage = {
      border = 'none',
    },
    symbol_info = {
      border = 'none',
    },
  },
}
