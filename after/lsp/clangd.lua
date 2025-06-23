--[[
clangd depends on compile_commands.json file to be in the project working directory.
Also, for project base configuratin, you should add another file "clangd.json" in the project working directory.
A sample file provided in the nvim configuration folder,
{
    "cmd": [
        "clangd.exe",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--compile_args_from=filesystem",
        "--compile-commands-dir=C:/VSCode/data/Projects/neoEsp32", -- project current working directory
        "--enable-config",
        "--completion-parse=always",
        "--completion-style=detailed",
        "--enable-config",
        "--function-arg-placeholders",
        "--header-insertion=iwyu",
        "-j=12",
        "--limit-results=0",
        "--pch-storage=memory",
        "--query-driver=C:/VSCode/data/.platformio/packages/toolchain-riscv32-esp/bin/riscv32-esp-elf-g++.exe"
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
--
-- local opts = require('custom.plugins.lsp-config.opts')
-- local capabilities = opts.capabilities
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }
---@type vim.lsp.Config
return {
  cmd = {
    'clangd',
    '--all-scopes-completion',
    '--background-index',
    '--clang-tidy',
    '--compile_args_from=filesystem',
    '--enable-config',
    '--completion-parse=always',
    '--completion-style=detailed',
    '--fallback-style=llvm',
    '--function-arg-placeholders',
    '--header-insertion=iwyu',
    '--header-insertion-decorators',
    '--inlay-hints',
    '-j=12',
    '--offset-encoding=utf-8',
    '--pch-storage=memory',
    '--query-driver=**',
  },
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
  -- on_new_config = function(new_config, new_root_dir)
  --   vim.notify(opts.printTable(new_config))
  --   vim.notify("launching on new config" .. new_root_dir)
  --   local uv = vim.uv or vim.loop
  --   local path = vim.fn.getcwd()
  --   local fname = string.format('%s\\%s.json', new_root_dir, new_config.name)
  --   vim.notify("you are here")
  --   vim.notify(fname)
  --   if uv.fs_stat(fname) then
  --     local ok, result = pcall(vim.fn.readfile, fname)
  --     if ok then
  --       result = table.concat(result)
  --       result = vim.json.decode(result)
  --       -- config.cmd = result.cmd
  --       local new = vim.tbl_deep_extend("force", new_config, result)
  --       for k, v in pairs(new) do
  --         new_config[k] = v
  --       end
  --       -- config.cmd = vim.tbl_deep_extend('force', config.cmd or {}, result.cmd) --working fine
  --     end
  --     opts.printTable(new_config)
  --   end
  -- end
}
