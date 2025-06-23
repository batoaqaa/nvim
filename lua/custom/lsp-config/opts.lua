local m = {}

function m.get_clangd_path()
  local avr_gcc
  if jit.os == 'Windows' then
    local handle = io.popen('where.exe clangd.exe') -- this gets path to program on unix
    if handle then
      avr_gcc = handle:read('*a'):sub(1, -2)
      handle:close()
    else
      avr_gcc = 'clangd'
    end
  else
    do
      local current_dir = vim.fn.getcwd()
      if current_dir:find('/esp') then
        avr_gcc = vim.fn.getenv('HOME') .. '/Documents/STU/LS/TP/esp-clang/bin/clangd'
      else
        avr_gcc = 'clangd'
      end
    end
  end
  return avr_gcc
end

function m.printTable(input)
  local printTable_cache = {}

  local function sub_printTable(t, indent)
    if printTable_cache[tostring(t)] then
      print(indent .. '*' .. tostring(t))
    else
      printTable_cache[tostring(t)] = true
      if type(t) == 'table' then
        for pos, val in pairs(t) do
          if type(val) == 'table' then
            print(indent .. '[' .. pos .. '] => ' .. tostring(t) .. ' {')
            sub_printTable(val, indent .. string.rep(' ', string.len(pos) + 8))
            print(indent .. string.rep(' ', string.len(pos) + 6) .. '}')
          elseif type(val) == 'string' then
            print(indent .. '[' .. pos .. '] => "' .. val .. '"')
          else
            print(indent .. '[' .. pos .. '] => ' .. tostring(val))
          end
        end
      else
        print(indent .. tostring(t))
      end
    end
  end

  if type(input) == 'table' then
    print(tostring(input) .. ' {')
    sub_printTable(input, '  ')
    print('}')
  else
    sub_printTable(input, '  ')
  end
end

--
function m.optstbl(name)
  local plugin = require('lazy.core.config').spec.plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end

--
function m.dump(o) -- return a string respresenting of a table
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. m.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

--
m.on_attach = function(client, bufnr)
  print('Attaching to: ' .. client.name .. ' attached to buffer ' .. bufnr)
end
--
-- local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
-- if has_cmp_lsp then
--   capabilities = cmp_lsp.default_capabilities(capabilities)
-- end
-- or
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
--
-- capabilities = vim.tbl_deep_extend('force', capabilities, {
--   textDocument = {
--     foldingRange = {
--       dynamicRegistration = false,
--       lineFoldingOnly = true,
--     },
--   },
-- })
-- or

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

-- capabilities = vim.tbl_deep_extend('force', capabilities, {
--   textDocument = {
--     foldingRange = {
--       dynamicRegistration = false,
--       lineFoldingOnly = true,
--     },
--   },
-- })

m.capabilities = capabilities
--

return m
