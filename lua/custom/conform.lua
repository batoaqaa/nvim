return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    lsp_fallback = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      cpp = { 'clang-format' },
      c = { 'clang-format' },
      css = { 'prettierd', 'prettier' },
      scss = { 'prettierd', 'prettier' },
      sh = { 'shfmt' },
      go = { 'goimports', 'gofmt' },
      html = { 'htmlbeautifier' },
      -- html = { 'prettier' },
      ini = { 'prettier' },
      dosini = { 'prettier' },
      json = { 'prettier' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { 'prettierd', 'prettier' },
      yaml = { 'yamlfmt' },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = 'fallback',
    },
    notify_on_error = false,

    format_on_save = {
      lsp_format = 'fallback',
      async = false,
      timeout_ms = 1000,
    },
    -- Set up format-on-save
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
      --clang_format = {
      --  command = 'clang-format',
      --   args = {
      --     '--style={'
      --       .. 'BasedOnStyle: microsoft,'
      --       .. 'PointerAlignment: Left,'
      --       .. 'BreakStringLiterals: false,'
      --       .. 'ColumnLimit: 0,'
      --       .. 'IndentWidth: 2,'
      --       .. 'ObjCBlockIndentWidth: 2,'
      --       .. 'ConstructorInitializerIndentWidth: 2 ,'
      --       .. 'ContinuationIndentWidth: 2 ,'
      --       .. 'ObjCSpaceBeforeProtocolList: false,'
      --       .. 'PenaltyBreakComment: 0,'
      --       .. 'SortIncludes: true,'
      --       .. 'TabWidth: 2,'
      --       .. 'UseTab: Never' --ForIndentation'
      --       .. '}',
      --     '--fallback-style=LLVM',
      --   },
      --   -- prepend_args = { '--style=file', '--fallback-style=LLVM' },         --OK
      --   -- prepend_args = { '--style=mozilla', '--fallback-style=LLVM' },    --OK
      --},
    },
  },
  config = function(_, opts)
    -- If you want the formatexpr, here is the place to set it
    vim.api.nvim_create_autocmd('FileType', {
      pattern = vim.tbl_keys(require('conform').formatters_by_ft),
      group = vim.api.nvim_create_augroup('conform_formatexpr', { clear = true }),
      callback = function()
        vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
      end,
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    require('conform').setup(opts)
    vim.g.auto_conform_on_save = true
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if vim.g.auto_conform_on_save then
          require('conform').format({ bufnr = args.buf, timeout_ms = nil })
        end
      end,
    })
    vim.api.nvim_create_user_command('ConformToggleOnSave', function()
      vim.g.auto_conform_on_save = not vim.g.auto_conform_on_save
      vim.notify('Auto-Conform on save: ' .. (vim.g.auto_conform_on_save and 'Enabled' or 'Disabled'))
    end, {})
  end,
}
--return {
--  { -- Autoformat
--    'stevearc/conform.nvim',
--    event = { "BufWritePre"},
--    cmd = {"ConformInfo"},
--    lazy = false,
--    keys = {
--      {
--        '<leader>f',
--        function()
--          require('conform').format { async = true, lsp_fallback = true }
--        end,
--        mode = '',
--        desc = '[F]ormat buffer',
--      },
--    },
--    opts = {
--      notify_on_error = false,
--
--      default_format_opts = {
--        lsp_format = "fallback",
--      },
--
--      format_on_save = {
--        lsp_format = "fallback",
--        async = false,
--        timeout_ms = 1000,
--      },
--      -- format_on_save = function(bufnr)
--      --   -- Disable "format_on_save lsp_fallback" for languages that don't
--      --   -- have a well standardized coding style. You can add additional
--      --   -- languages here or re-enable it for the disabled ones.
--      --   local disable_filetypes = { c = true, cpp = true }
--      --   return {
--      --     timeout_ms = 500,
--      --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
--      --     -- lsp_fallback = true,
--      --   }
--      -- end,
--      formatters_by_ft = {
--        cpp = { 'clang-format' },
--        c = { 'clang-format' },
--        css = { { 'prettierd', 'prettier' } },
--        scss = { { 'prettierd', 'prettier' } },
--        sh = {'shfmt'},
--        go = {'goimports', 'gofmt'},
--        html = { 'htmlbeautifier' },
--        -- html = { 'prettier' },
--        json = { 'prettier' },
--        lua = { 'stylua' },
--        -- Conform can also run multiple formatters sequentially
--        python = { 'isort', 'black' },
--        --
--        -- You can use a sub-list to tell conform to run *until* a formatter
--        -- is found.
--        javascript = { 'prettierd', 'prettier' },
--        yaml = { 'yamlfmt' },
--      },
--      -- formatters = {
--      --   clang_format = {
--      --     command = 'clang-format',
--      --     -- args = {
--      --     --   '--style={'
--      --     --     .. 'BasedOnStyle: microsoft,'
--      --     --     .. 'PointerAlignment: Left,'
--      --     --     .. 'BreakStringLiterals: false,'
--      --     --     .. 'ColumnLimit: 0,'
--      --     --     .. 'IndentWidth: 2,'
--      --     --     .. 'ObjCBlockIndentWidth: 2,'
--      --     --     .. 'ConstructorInitializerIndentWidth: 2 ,'
--      --     --     .. 'ContinuationIndentWidth: 2 ,'
--      --     --     .. 'ObjCSpaceBeforeProtocolList: false,'
--      --     --     .. 'PenaltyBreakComment: 0,'
--      --     --     .. 'SortIncludes: true,'
--      --     --     .. 'TabWidth: 2,'
--      --     --     .. 'UseTab: Never' --ForIndentation'
--      --     --     .. '}',
--      --     --   '--fallback-style=LLVM',
--      --     -- },
--      --     -- prepend_args = { '--style=file', '--fallback-style=LLVM' },         --OK
--      --     -- prepend_args = { '--style=mozilla', '--fallback-style=LLVM' },    --OK
--      --   },
--      -- },
--    },
--  },
--  init = function()
--    --vim.api.nvim_create_autocmd('FileType', {
--    --  pattern = vim.tbl_keys(require('conform').formatters_by_ft),
--    --  group = vim.api.nvim_create_augroup('conform_formatexpr', { clear = true }),
--    --  callback = function()
--    --    vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
--    --  end,
--    --})
--
--    --vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
--    --require('conform').setup(opts)
--    --vim.g.auto_conform_on_save = true
--    --vim.api.nvim_create_autocmd('BufWritePre', {
--    --  pattern = '*',
--    --  callback = function(args)
--    --    if vim.g.auto_conform_on_save then
--    --      require('conform').format { bufnr = args.buf, timeout_ms = nil }
--    --    end
--    --  end,
--    --})
--
--    --vim.api.nvim_create_user_command('ConformToggleOnSave', function()
--    --  vim.g.auto_conform_on_save = not vim.g.auto_conform_on_save
--    --  vim.notify('Auto-Conform on save: ' .. (vim.g.auto_conform_on_save and 'Enabled' or 'Disabled'))
--    --end, {})
--  end,
--  --config = function(_, opts)
--  --  require("conform").setup(opts)
--  --  vim.api.nvim_create_autocmd('FileType', {
--  --    pattern = vim.tbl_keys(require('conform').formatters_by_ft),
--  --    group = vim.api.nvim_create_augroup('conform_formatexpr', { clear = true }),
--  --    callback = function()
--  --      vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
--  --    end,
--  --  })
--  --  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
--  --  require('conform').setup(opts)
--  --  vim.g.auto_conform_on_save = true
--  --  vim.api.nvim_create_autocmd('BufWritePre', {
--  --    pattern = '*',
--  --    callback = function(args)
--  --      if vim.g.auto_conform_on_save then
--  --        require('conform').format { bufnr = args.buf, timeout_ms = nil }
--  --      end
--  --    end,
--  --  })
--  --  vim.api.nvim_create_user_command('ConformToggleOnSave', function()
--  --    vim.g.auto_conform_on_save = not vim.g.auto_conform_on_save
--  --    vim.notify('Auto-Conform on save: ' .. (vim.g.auto_conform_on_save and 'Enabled' or 'Disabled'))
--  --  end, {})
--  --end,
--}
---- vim: ts=2 sts=2 sw=2 et
