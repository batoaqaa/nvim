--[[
clangd depends on compile_commands.json file to be in the project working directory.
Also, for project base confiuratin, you should add another file "clangd.json" in the project working directory.
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
local opts = require 'custom.plugins.lsp.opts'
local local_cap = opts.capabilities
local_cap.offsetEncoding = { 'utf-8', 'utf-16' }

local rootPatterns = {
  'compile_commands.json',
  '.clangd',
  '.clang-tidy',
  'compile_flags.txt',
  '.clang-format',
  'configure.ac',
  '.git',
}

M = {
  -- command = get_clangd_path(),
  -- arguments = {
  --   "--query-driver=/usr/bin/clang++",
  --   "--background-index"
  -- },
  -- cmd = { 'clangd' },
  on_atach = opts.on_attach,
  capabilities = local_cap,
  single_file_support = true, -- must be either nil or true to have LSP server start even with no root_dir
  filetypes = { 'c', 'h', 'cpp', 'hpp', 'objc', 'objcpp', 'cuda', 'proto' },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    fallback_flags = { '-std=c++17' },
    clangdFileStatus = true,
    -- compilationDatabasePath = vim.fn.getcwd(),
  },
  keys = {
    { '<leader>cR', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
  },
  root_dir = function(fname)
    local path = require('lspconfig.util').root_pattern(table.unpack(rootPatterns))(fname)
        or require('lspconfig.util').find_git_ancestor(fname)
        or require('lspconfig.util').path.dirname(fname)
    return path
  end,
  -- commands = {},
}

M.on_new_config = function(config)
  -- opts.printTable(config)
  local uv = vim.uv or vim.loop
  local path = vim.fn.getcwd()
  local fname = string.format('%s\\%s.json', path, config.name)
  if uv.fs_stat(fname) then
    local ok, result = pcall(vim.fn.readfile, fname)
    if ok then
      result = table.concat(result)
      result = vim.json.decode(result)
      config.cmd = result.cmd
      -- config.cmd = vim.tbl_deep_extend('force', config.cmd or {}, result.cmd)    --working fine
    end
    -- opts.printTable(config)
  end
end

return M