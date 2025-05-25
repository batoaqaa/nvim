-- disable
---@type vim.lsp.Config
return {
  arduino_language_server = {
    cmd = { "arduino-language-server" },
    filetypes = { "arduino" },
    root_markers = { '*.ino' },
  },
}
