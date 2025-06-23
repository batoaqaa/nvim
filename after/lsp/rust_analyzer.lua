---@type vim.lsp.Config
return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = {
    'Cargo.toml',
    'Cargo.lock',
  },
  settings = {
    ['rust-analyzer'] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = true,
      diagnostics = { enable = true },
      check = {
        command = 'clippy', --TODO: `rustup component add clippy` to install clippy
        extraArgs = { '--no-deps' },
      },
    },
  },
}
