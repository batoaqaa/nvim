-- local handle = io.popen("where.exe clangd") -- this gets path to program on unix
-- local avr_gcc
-- if handle then
--   avr_gcc = handle:read("*a"):sub(1, -2)
--   handle:close()
-- else
--   avr_gcc = nil;
-- end
--
--
-- if jit.os == 'Windows' then
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
-- function _G.expand(...)
--   local expanded_value = {}
--
--   for i = 1, select('#', ...) do
--     local value = select(i, ...)
--     table.insert(expanded_value, vim.inspect(value))
--   end
--   return expanded_value
-- end
--
-- function _G.put(...)
--   local expanded_value = expand(...)
--   print(table.concat(expanded_value, '\n<<<<<\n\n'))
-- end
--
-- function _G.put_text(...)
--   local expanded_value = expand(...)
--
--   local lines = vim.split(table.concat(expanded_value, '\n'), '\n')
--   local lnum = vim.api.nvim_win_get_cursor(0)[1]
--   vim.fn.append(lnum, lines)
--   return ...
-- end
--
-- -----------------------   MY  -----------------------------
-- function _G.dump(o) -- return a string respresenting of a table
--   if type(o) == 'table' then
--     local s = '{ '
--     for k, v in pairs(o) do
--       if type(k) ~= 'number' then
--         k = '"' .. k .. '"'
--       end
--       s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   elseif type(o) == 'string' then
--     return o
--   else
--     return tostring(o)
--   end
-- end

-----------------------   MY  -----------------------------
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
