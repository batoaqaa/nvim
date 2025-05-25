return {
  arduino_language_server = {
    cmd = { "arduino-language-server" },
    filetypes = { "arduino" },
    root_markers = { '*.ino' },
  },
  -- bashls = require('custom.plugins.lsp-config.lang-servers.bashls'),
  biome = {
    cmd = { "biome", "lsp-proxy" },
    filetypes = { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" }, 
    root_markers = { 'biome.json', 'biome.jsonc' } ,
  },
}
