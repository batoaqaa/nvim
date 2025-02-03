local opts = require('custom.plugins.lsp-config.opts')
return {
  capabilities = opts.capabilities,
  -- on_attach = opts.on_attach,
  settings = {
    ['rust-analyzer'] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = {
        command = 'clippy', --TODO: `rustup component add clippy` to install clippy
        extraArgs = { '--no-deps' },
      },
    },
  },
}
