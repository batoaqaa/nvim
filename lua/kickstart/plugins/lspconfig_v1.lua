local handle = io.popen 'where.exe clangd' -- this gets path to program on unix
local avr_gcc
if handle then
  avr_gcc = handle:read('*a'):sub(1, -2)
  handle:close()
else
  avr_gcc = nil
end
--avr_gcc = 'D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\riscv32-esp-elf\\include\\c++\\8.4.0\\riscv32-esp-elf'
--avr_gcc = 'D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\riscv32-esp-elf\\include'
--avr_gcc = "D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\bin\\riscv32-esp-elf-g++.exe"

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
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
    { 'williamboman/mason-lspconfig.nvim' },
    --
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
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
    {
      'hrsh7th/cmp-nvim-lsp',
      opts = {
        sources = {
          { name = 'nvim_lsp' },
        },
      },
    },
    --------
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = {} },
    { 'williamboman/nvim-lsp-installer', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
  },
  --
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
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
        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { nil }) -- added {nil} to get rid of warning
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })
    --
    local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
    custom_capabilities = vim.tbl_deep_extend('force', custom_capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- client and bufnr need for other plugin.
    local custom_attach = function(client, bufnr)
      if jit.os == 'Windows' then
        print('Windows 11 Attaching to: ' .. client.name)
      else
        print('Attaching to: ' .. client.name)
      end
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    end
    --
    local clangd_attach = function(client, bufnr)
      if jit.os == 'Windows' then
        print('Windows 11 Attaching to: ' .. avr_gcc)
        --print('Windows 11 Attaching to: ' .. client.name .. avr_gcc)
      else
        print('Attaching to: ' .. client.name)
      end
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    end
    local servers = {
      clangd = {
        capabilities = custom_capabilities,
        -- cmd = {
        --   vim.fn.stdpath("data") .. "\\mason\\packages\\clangd\\clangd_18.1.3/bin/clangd.exe",
        --   --          "--background-index",
        --   "D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\bin\\riscv32-esp-elf-g++*" and
        --   "--query-driver=D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\bin\\riscv32-esp-elf-g++*",
        --   --"--query-driver=D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp*"
        --   --"--query-driver=D:\\VSCode\\data\\.platformio\\packages\\toolchain-riscv32-esp\\riscv32-esp-elf\\include*"
        -- },
        on_attach = clangd_attach,
        filetypes = { 'c', 'cpp', 'h', 'hpp', 'inl', 'objc', 'objcpp', 'cuda', 'proto' },
      },
      -- gopls = {},
      html = {
        capabilities = custom_capabilities,
        on_attach = custom_attach,
      },
      --
      pyright = {
        capabilities = custom_capabilities,
        on_attach = custom_attach,
      },
      --
      yamlls = {
        capabilities = custom_capabilities,
        on_attach = custom_attach,
        filetypes = { 'yaml', 'yml', 'clangd' },
      },
      --
      -- arduino_language_server = {
      --   capabilities = custom_capabilities,
      --   on_attach = custom_attach,
      -- },
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      tsserver = {
        capabilities = custom_capabilities,
        on_attach = custom_attach,
      },
      --
      --setting up lua lsp
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
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
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
        on_attach = custom_attach,
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'shfmt', --
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      -- ensure_installed = vim.tbl_keys(servers or {}),  --{ 'clangd', 'html', 'lua_ls', 'pyright' },
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format Lua code
      --   'shfmt',  --
      -- }),
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', custom_capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
