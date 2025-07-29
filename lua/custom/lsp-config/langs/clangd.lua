--[[
clangd depends on compile_commands.json file to be in the project working directory.
Also, for project base configuratin, you should add another file "clangd.json" in the project working directory.
A sample file provided in the nvim configuration folder,
{
    "cmd": [
      "C:\\VSCode\\esp-clang17\\bin\\clangd",
      "--all-scopes-completion",
      "--background-index",
      "--clang-tidy",
      "--compile_args_from=filesystem",
      "--compile-commands-dir=.",
      "--enable-config",
      "--completion-parse=always",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--header-insertion-decorators",
      "-j=12",
      "--log=verbose",
      "--offset-encoding=utf-8",
      "--pch-storage=memory",
      "--pretty",
      "--query-driver=**",
      "--ranking-model=decision_forest"
    ]
}
]]

-- cmd = { 'clangd' },
-- settings = {
--   clangd = {
--     arguments = {
--       '--log=verbose', -- for debugging
--       '--all-scopes-completion',
--       '--background-index',
--       '--clang-tidy',
--       '--compile_args_from=filesystem',
--       '--enable-config',
--       '--completion-parse=always',
--       '--completion-style=detailed',
--       '--enable-config',
--       '--function-arg-placeholders',
--       '--header-insertion=iwyu',
--       '-j=12',
--       '--limit-results=0',
--       '--pch-storage=memory',
--     },
--   },
-- },
-- local uv = vim.uv or vim.loop
-- local opts = require('custom.plugins.lsp-config.opts')
-- local capabilities = opts.capabilities
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

local cmd = {
  'clangd',
  '--all-scopes-completion',
  '--background-index',
  '--clang-tidy',
  '--compile_args_from=filesystem',
  '--compile-commands-dir=.',
  '--enable-config',
  '--completion-parse=always',
  '--completion-style=detailed',
  -- '--fallback-style=llvm',
  -- '--function-arg-placeholders',
  '--header-insertion=iwyu',
  '--header-insertion-decorators',
  -- '--inlay-hints',
  '-j=12',
  '--log=verbose', -- for debugging
  --   '--log=error',
  '--offset-encoding=utf-8',
  '--pch-storage=memory',
  '--pretty',
  '--query-driver=**',
  '--ranking-model=decision_forest',
}
local path = vim.fn.getcwd()
local fname = string.format('%s\\clangd.json', path)
if vim.fn.filereadable(fname) == 1 then
  local ok, result = pcall(vim.fn.readfile, fname)
  if ok then
    result = table.concat(result)
    result = vim.json.decode(result)
    cmd = vim.tbl_deep_extend('force', cmd or {}, result.cmd) --working fine
    -- print(vim.inspect(cmd))
  end
end

---@type vim.lsp.Config
return {
  cmd = cmd,
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    'CMakeLists.txt',
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
    vim.uv.cwd(),
  },
  single_file_support = true,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    fallback_flags = { '-std=c++17' },
    clangdFileStatus = true,
    compilationDatabasePath = vim.fn.getcwd(),
  },
}
