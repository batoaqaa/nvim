-- disable
---@type vim.lsp.Config
return {
  biome = {
    cmd = { "biome", "lsp-proxy" },
    filetypes = { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" }, 
    root_markers = { 'biome.json', 'biome.jsonc' } ,
  },
}
