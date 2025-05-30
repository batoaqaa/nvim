-- Lazygit plugin
-- Keep inside the config of lazy as shown earlier
return {
  "kdheepak/lazygit.nvim",
  lazy         = false,
  cmd          = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  -- custom keymap to start lazygit
  keys         = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" }
  },
  config       = function()
    require("telescope").load_extension("lazygit")
  end,
}
