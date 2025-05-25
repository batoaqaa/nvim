---@type vim.lsp.Config
return {
  -- lazy-load schemastore when needed
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = true },
  root_makers = { ".git" },
}
