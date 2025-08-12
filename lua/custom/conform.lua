-- uses: core.utils.text_manipulation
-- local function fallback_format(bufnr)
--   -- Get the buffer number of the current buffer
--   local current_buf = vim.api.nvim_get_current_buf()
--   bufnr = bufnr or current_buf
--
--   vim.api.nvim_echo({
--     { 'fall!', 'ErrorMsg' },
--   }, true, {})
--   -- Check buffer valid state
--   if not vim.api.nvim_buf_is_loaded(bufnr) then
--     return
--   end
--   -- if not vim.api.nvim_buf_get_option(bufnr, 'modifiable') then
--   if not vim.api.nvim_get_option_value('modifiable', { buf = bufnr }) then
--     return
--   end
--   if vim.api.nvim_get_option_value('buftype', { buf = bufnr }) ~= '' then
--     return
--   end
--   if vim.api.nvim_get_option_value('readonly', { buf = bufnr }) then
--     return
--   end
--   if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == '' then
--     return
--   end
--   if vim.api.nvim_get_option_value('binary', { buf = bufnr }) then
--     return
--   end
--
--   -- Now do trimming and squeezing blank lines, etc
--   local with_preserved_view = require('core.utils.nvim_utils').with_preserved_view
--   local utils = require('core.utils.text_manipulation')
--
--   -- utils.trim_whitespace(bufnr)
--   -- utils.squeeze_blank_lines(bufnr)
--   utils.clean_buffer(bufnr)
--
--   -- Try LSP formatting if any client attached
--   local clients = vim.lsp.get_clients({ bufnr = bufnr })
--   if #clients > 0 then
--     if
--         not clients[1]:supports_method('textDocument/willSaveWaitUntil', { bufnr = bufnr })
--         and clients[1]:supports_method('textDocument/formatting', { bufnr = bufnr })
--     then
--       vim.lsp.buf.format({ bufnr = bufnr, id = clients[1].id, timeout_ms = 1000 })
--     end
--     -- vim.lsp.buf.format({ bufnr = bufnr, async = false })
--     -- vim.api.nvim_echo({
--     --     { 'if!', 'ErrorMsg' },
--     -- }, true, {})
--   else
--     -- fallback manual indent reformat
--     vim.api.nvim_buf_call(bufnr, function()
--       with_preserved_view(function()
--         vim.cmd('normal! gg=G')
--       end)
--     end)
--     vim.api.nvim_echo({
--       { 'else!', 'ErrorMsg' },
--     }, true, {})
--   end
-- end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
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
    -- lsp_fallback = true,

    formatters_by_ft = {
      cpp = { 'clang_format' },
      c = { 'clang-format' },
      css = { 'prettierd' }, -- 'prettier' },
      -- Conform can also run multiple formatters sequentially
      scss = { 'prettier', 'prettierd' },
      dosini = { 'prettier' },
      go = { 'goimports', 'gofmt' },
      graphql = { 'prettierd' },
      html = { 'prettierd' },
      ini = { 'prettier' },
      javascript = { 'prettierd' }, -- 'prettier' },
      javascriptreact = { 'prettierd' },
      json = { 'prettierd' },
      -- lua = { 'stylua', lsp_format = 'fallback' },
      lua = { 'stylua' },
      markdown = { 'prettierd' },
      python = { 'isort', 'black' },
      svelte = { 'prettierd' },
      sh = { 'shfmt' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      yaml = { 'prettierd' },
      -- yaml = { 'yamlfmt' },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = 'fallback',
    },
    notify_on_error = false,

    format_on_save = {

      -- lsp_fallback = fallback_format,
      timeout_ms = 500,
      lsp_format = 'fallback',
      async = false,
    },
    -- Set up format-on-save
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
      clang_format = {
        command = 'clang-format',
        args = {
          '--style={'
            .. 'AlignAfterOpenBracket: Align,'
            .. 'BasedOnStyle: mozilla,'
            --     --
            -- .. 'AlwaysBreakAfterDefinitionReturnType: TopLevel,' --deprecated use BreakAfterReturnType with TopLevelDefinitions
            -- .. 'BreakAfterReturnType: None,'
            -- .. 'BreakAfterReturnType: All,'
            -- .. 'BreakAfterReturnType: AllDefinitions,'
            .. 'BreakAfterReturnType: TopLevelDefinitions,'
            -- .. 'BreakAfterReturnType: TopLevel,'
            --     --
            --     .. 'BraceWrapping:{'
            --     .. 'AfterCaseLabel:  false,'
            --     .. 'AfterClass:      true,'
            --     .. 'AfterControlStatement: Never,'
            --     .. 'AfterEnum:       true,'
            --     .. 'AfterExternBlock: true,'
            --     .. 'AfterFunction:   true,'
            --     .. 'AfterNamespace:  false,'
            --     .. 'AfterObjCDeclaration: false,'
            --     .. 'AfterStruct:     true,'
            --     .. 'AfterUnion:      true,'
            --     .. 'BeforeCatch:     false,'
            --     .. 'BeforeElse:      false,'
            --     .. 'BeforeLambdaBody: false,'
            --     .. 'BeforeWhile:     false,'
            --     .. 'IndentBraces:    false,'
            --     .. 'SplitEmptyFunction: true,'
            --     .. 'SplitEmptyRecord: false,'
            --     .. 'SplitEmptyNamespace: true,'
            --     .. '},'
            --     --
            --     .. 'BreakStringLiterals: false,'
            .. 'ColumnLimit: 120,'
            --     .. 'ConstructorInitializerIndentWidth: 2 ,'
            --     .. 'ContinuationIndentWidth: 2 ,'
            --     .. 'IndentWidth: 2,'
            --     .. 'ObjCBlockIndentWidth: 2,'
            --     .. 'ObjCSpaceBeforeProtocolList: false,'
            --     .. 'PenaltyBreakComment: 0,'
            --     .. 'PointerAlignment: Right,'
            --     .. 'SortIncludes: true,'
            --     .. 'TabWidth: 2,'
            --     .. 'UseTab: Never' --ForIndentation'
            .. '}',
          '--fallback-style=LLVM',
        }, --OK
        --
        -- prepend_args = { '--style=file', '--fallback-style=LLVM' },         --OK
        --
        -- prepend_args = { '--style=mozilla', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=google', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=microsoft', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=LLVM', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=Chromium', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=WebKit', '--fallback-style=LLVM' }, --OK
        -- prepend_args = { '--style=GNU', '--fallback-style=LLVM' }, --OK
      },
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
