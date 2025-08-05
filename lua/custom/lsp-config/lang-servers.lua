return {
  arduino_language_server = {
    cmd = { 'arduino-language-server' },
    filetypes = { 'arduino' },
    root_markers = { '*.ino' },
  },
  biome = {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = {
      'astro',
      'css',
      'graphql',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'svelte',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
      'vue',
    },
    root_markers = { 'biome.json', 'biome.jsonc' },
  },
  docker_compose_language_service = {
    cmd = { 'docker-compose-langserver', '--stdio' },
    filetypes = { 'yaml.docker-compose' },
    root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
  },
  ts_ls = require('custom.lsp-config.langs.ts_ls'),
  -- clangd = require('custom.lsp-config.langs.clangd'),
}
