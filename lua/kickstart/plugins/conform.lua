return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   return {
      --     timeout_ms = 500,
      --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      --     -- lsp_fallback = true,
      --   }
      -- end,
      formatters_by_ft = {
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        css = { 'biome' },
        html = { 'biome' },
        json = { 'prettier' },
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { 'prettierd', 'prettier' },
        yaml = { 'yamlfmt' },
      },
      -- formatters = {
      --   clang_format = {
      --     command = 'clang-format',
      --     -- args = {
      --     --   '--style={'
      --     --     .. 'BasedOnStyle: microsoft,'
      --     --     .. 'PointerAlignment: Left,'
      --     --     .. 'BreakStringLiterals: false,'
      --     --     .. 'ColumnLimit: 0,'
      --     --     .. 'IndentWidth: 2,'
      --     --     .. 'ObjCBlockIndentWidth: 2,'
      --     --     .. 'ConstructorInitializerIndentWidth: 2 ,'
      --     --     .. 'ContinuationIndentWidth: 2 ,'
      --     --     .. 'ObjCSpaceBeforeProtocolList: false,'
      --     --     .. 'PenaltyBreakComment: 0,'
      --     --     .. 'SortIncludes: true,'
      --     --     .. 'TabWidth: 2,'
      --     --     .. 'UseTab: Never' --ForIndentation'
      --     --     .. '}',
      --     --   '--fallback-style=LLVM',
      --     -- },
      --     -- prepend_args = { '--style=file', '--fallback-style=LLVM' },         --OK
      --     -- prepend_args = { '--style=mozilla', '--fallback-style=LLVM' },    --OK
      --   },
      -- },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
