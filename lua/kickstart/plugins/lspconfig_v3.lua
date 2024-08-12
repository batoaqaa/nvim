-- local handle = io.popen("where.exe clangd") -- this gets path to program on unix
-- local avr_gcc
-- if handle then
--   avr_gcc = handle:read("*a"):sub(1, -2)
--   handle:close()
-- else
--   avr_gcc = nil;
-- end
--
-- local on_windows = vim.loop.os_uname().version:match 'Windows'
-- local on_windows = jit.os:match 'Windows'
-- local function join_paths(...)
--   local path_sep = on_windows and '\\' or '/'
--   local result = table.concat({ ... }, path_sep)
--   return result
-- end
--
-- local localappdata = os.getenv("LocalAppData")
-- local runtimepath = join_paths(localappdata , 'nvim')
--
-- local temp_dir = os.getenv('TEMP')
-- local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
-- local lspconfig_path = join_paths(package_root, 'test', 'start', 'nvim-lspconfig')
-- --
--
-- local LazyUtil = require 'lazy.core.util'
--
local M = {}
function M.dump(o) -- return a string respresenting of a table
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end
--
---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}
--
function M.on_supports_method(method, fn)
  vim.notify('[on_test2.0] ', vim.log.levels.INFO)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = 'k' })
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspSupportsMethod',
    callback = function(args)
      vim.notify('[on_test2.1] ', vim.log.levels.INFO)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client and method == args.data.method then
        vim.notify('[on_test2.2] ', vim.log.levels.INFO)
        return fn(client, buffer)
      end
    end,
  })
end

M.icons = {
  misc = {
    dots = '󰇘',
  },
  ft = {
    octo = '',
  },
  dap = {
    Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '.>',
  },
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  kinds = {
    Array = ' ',
    Boolean = '󰨙 ',
    Class = ' ',
    Codeium = '󰘦 ',
    Color = ' ',
    Control = ' ',
    Collapsed = ' ',
    Constant = '󰏿 ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = '󰊕 ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = '󰊕 ',
    Module = ' ',
    Namespace = '󰦮 ',
    Null = ' ',
    Number = '󰎠 ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = '󰆼 ',
    TabNine = '󰏚 ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = '󰀫 ',
  },
}
--
---@param name string
function M.opts(name) -- get opts table of a plugin
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require 'lazy.core.plugin'
  return Plugin.values(plugin, 'opts', false)
end

function M.merge(a, b) -- merge two tables
  if type(a) == 'table' and type(b) == 'table' then
    for k, v in pairs(b) do
      if type(v) == 'table' and type(a[k] or false) == 'table' then
        M.merge(a[k], v)
      else
        a[k] = v
      end
    end
  end
  return a
end

return {
  'neovim/nvim-lspconfig',
  cmd = 'LspInfo',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        {
          'williamboman/mason.nvim', -- must be loaded before dependents
          build = ':MasonUpdate',
          config = true,
          opts = {
            ui = {
              icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗',
              },
            },
          },
        },
      },
    },
    --
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        --dependencies = { 'williamboman/mason.nvim' }, -- must be loaded before dependents
        lazy = true,
        ensure_installed = {
          'clangd',
          'clang-format',
          --'html-lsp',
          --'json-lsp',
          'lua-language-server',
          'stylua',
          --
          --'pyright',
          'python-lsp-server',
          'isort',
          'black',
          --
          'biome',
          --'css-lsp',
          --'prettier',
          --'prettierd',
          --'htmlbeautifier',
          --'typescript-language-server',
          'yaml-language-server',
          'yamlfmt',
        },
      },
    },
    --
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      -- opts = {
      --   library = {
      --     -- See the configuration section for more details
      --     -- Load luvit types when the `vim.uv` word is found
      --     { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      --   },
      -- },
      config = true,
    },
    { -- optional completion source for require statements and module annotations
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
    { -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers.
      'hrsh7th/cmp-nvim-lsp',
      opts = {
        sources = {
          { name = 'nvim_lsp' },
        },
      },
    },
    ---Extensible UI for Neovim notifications and LSP progress messages
    { 'j-hui/fidget.nvim', opts = {} },
    --
    {
      'p00f/clangd_extensions.nvim',
      -- --lazy = true,
      config = function() end,
      opts = {
        inlay_hints = {
          --inline = true,
          inline = false,
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
  },

  opts = function()
    local opts = {
      -- ---@type vim.diagnostic.Opts
      -- diagnostics = {
      --   underline = true,
      --   update_in_insert = false,
      --   virtual_text = {
      --     spacing = 4,
      --     source = 'if_many',
      --     prefix = '●',
      --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      --     -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      --     -- prefix = "icons",
      --   },
      --   severity_sort = true,
      --   signs = {
      --     text = {
      --       [vim.diagnostic.severity.ERROR] = M.icons.diagnostics.Error,
      --       [vim.diagnostic.severity.WARN] = M.icons.diagnostics.Warn,
      --       [vim.diagnostic.severity.HINT] = M.icons.diagnostics.Hint,
      --       [vim.diagnostic.severity.INFO] = M.icons.diagnostics.Info,
      --     },
      --   },
      -- },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        --enabled = true,
        enabled = false,
        --exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- Enable lsp cursor word highlighting
      document_highlight = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      --@type lspconfig.options
    }
    return opts
  end,
  --
  config = function(_, opts)
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'
    --local opts = require 'lspconfig.opts'
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    --local clangd_ext = require 'clangd_extensions'

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
    }

    local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

    --bufkeymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'open float [D]iagnostic' })
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Go to previous [D]iagnostic message' })
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Go to next [D]iagnostic message' })
    vim.keymap.set('n', 'gl', function()
      -- If we find a floating window, close it.
      local found_float = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= '' then
          vim.api.nvim_win_close(win, true)
          found_float = true
        end
      end
      if found_float then
        return
      end
      vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
    end, { desc = 'Toggle float Diagnostics' })
    --
    vim.api.nvim_create_autocmd('LspAttach', {
      group = lsp_cmds,
      desc = 'LSP actions',
      callback = function(args)
        --local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufkeymap = function(mode, keys, func, mapopts)
          local options = { buffer = args.buf, noremap = true, silent = true }
          if mapopts then
            options = vim.tbl_extend('force', options, mapopts)
          end
          -- mapopts.noremap = true
          -- mapopts.buffer = args.buf
          -- local tmp = { buffer = args.buf }
          -- M.merge(mapopts, tmp)
          --local merge = { noremap = true, unpack(mapopts) }
          --local merge = { buffer = args.buf , unpack(mapopts) }
          --vim.api.nvim_set_keymap(mode, keys, func, mapopts)
          vim.keymap.set(mode, keys, func, options)
        end
        -- local bufkeymap = function(mode, lhs, rhs)
        --   vim.keymap.set(mode, lhs, rhs, { buffer = true })
        -- end
        --
        --bufkeymap('i', '<C-Space>', '<C-x><C-o>', { desc = 'Trigger code completion' })
        bufkeymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
        bufkeymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
        bufkeymap('n', 'gI', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
        bufkeymap('n', 'go', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
        bufkeymap('n', 'gr', vim.lsp.buf.references, { desc = 'List references' })

        bufkeymap('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = 'List document symbols' })
        bufkeymap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { desc = 'List workspace symbols' })

        bufkeymap('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation' })
        bufkeymap('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Show signature' })
        bufkeymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })

        bufkeymap('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
        bufkeymap({ 'n', 'x' }, '<F3>', function()
          vim.lsp.buf.format { async = true }
        end, { desc = 'format buffer' })
        bufkeymap('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })

        bufkeymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
        bufkeymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
        bufkeymap('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = 'List workspace folders' })

        -- local id = vim.tbl_get(args, 'data', 'client_id')
        -- local client = id and vim.lsp.get_client_by_id(id)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })
        if client then
          if client.supports_method 'textDocument/formatting' then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              group = fmt_group,
              desc = 'Fromat current buffer',
              callback = function()
                vim.lsp.buf.format { bufnr = args.buf, async = false, timeout_ms = 10000, id = client.id }
              end,
            })
          end
          --
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            bufkeymap('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }, { bufnr = args.buf })
            end, { desc = '[T]oggle Inlay [H]ints' })
          end
          --
          if client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          --
          if vim.fn.has 'nvim-0.10' == 1 then
            -- inlay hints
            -- if client.supports_method 'textDocument/inlayHint' then
            --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            -- end
            --
            -- -- Enable auto-completion
            -- if client.supports_method 'methods.textDocument/completion' then
            --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            -- end
            -- code lens
            if client.supports_method 'textDocument/codeLens' then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                buffer = args.buf,
                callback = vim.lsp.codelens.refresh,
              })
            end
          end
          --
          ----------Start
          -- if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
          --   opts.diagnostics.virtual_text.prefix = vim.fn.has 'nvim-0.10.0' == 0 and '●'
          --     or function(diagnostic)
          --       local icons = M.icons.diagnostics
          --       for d, icon in pairs(icons) do
          --         if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          --           return icon
          --         end
          --       end
          --     end
          -- end
          --
          -- vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
          ----------End
        end
        --
      end,
    })
    local custom_capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
    custom_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
    --local custom_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
    -- custom_capabilities = vim.tbl_deep_extend('force', custom_capabilities, require('cmp_nvim_lsp').default_capabilities())
    --
    local custom_attach = function() --client, bufnr)
      -- if jit.os == 'Windows' then
      --   print('Windows 11 Attaching to: ' .. client.name .. ' attached to buffer ' .. bufnr)
      -- else
      --   print('Attaching to: ' .. client.name .. ' attached to buffer ' .. bufnr)
      -- end
      -- --vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    end
    --
    require('mason').setup {}
    --vim.list_extend(ensure_installed, { 'stylua', })
    require('mason-lspconfig').setup {
      --ensure_installed = { 'clangd', 'cssls', 'html', 'jsonls', 'lua_ls', 'pyright', 'tsserver', 'yamlls' },
      automatic_installation = true,
      handlers = {
        function(server_name)
          --local server = servers[server_name] or {}
          -- server.on_attach = custom_attach
          -- server.capabilities = custom_capabilities
          --require('lspconfig')[server_name].setup(server)
          lspconfig[server_name].setup {
            --on_attach = custom_attach,
            on_attach = function(client, bufnr)
              local _, err = pcall(custom_attach, client, bufnr)
              if err then
                vim.notify('[on_attach] error: ' .. err, vim.log.levels.ERROR)
              else
                vim.notify('[on_attach] ' .. client.name .. ' attached to buffer ' .. bufnr, vim.log.levels.INFO)
              end
            end,
            capabilities = custom_capabilities,
          }
        end,
        ['clangd'] = function()
          lspconfig.clangd.setup {
            capabilities = custom_capabilities,
            root_dir = function(fname)
              return require('lspconfig.util').root_pattern(
                'Makefile',
                'configure.ac',
                'configure.in',
                'config.h.in',
                'meson.build',
                'meson_options.txt',
                'build.ninja'
              )(fname) or require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt')(fname) or require('lspconfig.util').find_git_ancestor(
                fname
              )
            end,
            inlay_hints = {
              inline = true,
            },
            flags = {
              debounce_text_changes = 150,
              allow_incremental_sync = false,
            },
            cmd = {
              'clangd',
              '--background-index',
              '--clang-tidy',
              '--header-insertion=iwyu',
              '--completion-style=detailed',
              '--function-arg-placeholders',
              '--fallback-style=llvm',
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
            on_attach = function(client, bufnr)
              local _, err = pcall(custom_attach, client, bufnr)
              if err then
                vim.notify('[on_attach] error: ' .. err, vim.log.levels.ERROR)
              else
                vim.notify('[clangd on_attach] ' .. client.name .. ' attached to buffer ' .. bufnr, vim.log.levels.INFO)
                --require('clangd_extensions.inlay_hints').setup_autocmd()
                --require('clangd_extensions.inlay_hints').set_inlay_hints()
                --local clangd_ext_opts = require('clangd_extensions').opts
                require 'clangd_extensions'
                local clangd_ext_opts = M.opts 'clangd_extensions.nvim'
                --require('clangd_extensions').setup(vim.tbl_deep_extend('force', M.opts 'clangd_extensions.nvim' or {}, configs.clangd))
                vim.notify('[clangd_ext dump0] ' .. M.dump(clangd_ext_opts) .. '\n\n', vim.log.levels.INFO)
                --vim.notify('\n\n[clangd  dump1] ' .. M.dump { clangd_opts } .. '\n\n', vim.log.levels.INFO)
                vim.notify('\n\n[clangd  dump1] ' .. M.dump(configs.clangd) .. '\n\n', vim.log.levels.INFO)
                require('clangd_extensions').setup(vim.tbl_deep_extend('force', clangd_ext_opts or {}, { server = configs.clangd['manager'] }))
                --require('clangd_extensions').setup(vim.tbl_deep_extend('force', clangd_ext_opts or {}, { server = clangd_opts }))
                clangd_ext_opts = M.opts 'clangd_extensions.nvim'
                vim.notify('\n\n[clangd_ext dump2] ' .. M.dump(clangd_ext_opts) .. '\n\n', vim.log.levels.INFO)
              end
            end,
            -- keys = {
            --   { '<leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
            -- },
          }
        end,
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup {
            on_attach = function(client, bufnr)
              local _, err = pcall(custom_attach, client, bufnr)
              if err then
                vim.notify('[on_attach] error: ' .. err, vim.log.levels.ERROR)
              else
                vim.notify('[on_attach] ' .. client.name .. ' attached to buffer ' .. bufnr, vim.log.levels.INFO)
              end
            end,
            --on_attach = custom_attach,
            capabilities = custom_capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = {
                    vim.api.nvim_get_runtime_file('', true),
                  },
                  checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end,
      },
    }
  end,
}
