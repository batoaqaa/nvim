return {
  -- { 'filNaj/tree-setter', opts = {
  --   tree_setter = {
  --     enable = true,
  --   },
  -- } },
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'tsx',
      'astro',
      'markdown_inline',
      'svelte',
      'graphql',
      'dockerfile',
      'gitignore',
      'query',
      'rust',

      'arduino',
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'sql',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    -- ignore_install = { 'query' },

    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      -- disable = { 'query' },
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
-- vim: ts=2 sts=2 sw=2 et
