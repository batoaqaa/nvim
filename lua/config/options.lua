-- This file is automatically loaded by plugins.core
-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = 'auto'

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

-- LazyVim automatically configures lazygit:
--  * theme, based on the active colorscheme.
--  * editorPreset to nvim-remote
--  * enables nerd font icons
-- Set to false to disable.
vim.g.lazygit_config = true

-- Options for the LazyVim statuscolumn
vim.g.lazyvim_statuscolumn = {
  folds_open = false,  -- show fold sign when fold is open
  folds_githl = false, -- highlight fold sign with git sign color
}

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")
vim.g.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
vim.g.shellcmdflag =
'-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[Out-File:Encoding]=utf8;Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
vim.g.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.g.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
vim.g.shellquote = ''
vim.g.shellxquote = ''

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = true

vim.o.exrc = true -- loading local configuration files using the 'exrc' option

local opt = vim.opt
opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2                                    -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true                                      -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                                   -- Enable highlighting of the current line

-- LazyVim auto format
vim.g.autoformat = true
opt.formatexpr = "v:lua.require'conform'.formatexpr()" --"v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = 'jcroqlnt'                         -- tcqj
opt.grepformat = '%f:%l:%c:%m'
--
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true    -- Ignore case
opt.inccommand = 'split' -- preview incremental substitute
opt.jumpoptions = 'view'
opt.laststatus = 3       -- global statusline
opt.linebreak = true     -- Wrap lines at convenient points
opt.list = true          -- Show some invisible characters (tabs...
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.mouse = 'a'          -- Enable mouse mode
opt.number = true        -- Print line number
opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
-- opt.completeopt = { "menuone", "fuzzy", "noinsert", "preview" }
opt.pumblend = 10         -- Popup blend
opt.pumheight = 10        -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 10        -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false   -- Dont show mode since we have a statusline
opt.sidescrolloff = 8  -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true   -- Don't ignore case with capitals
opt.spelllang = { 'en' }
opt.spelloptions:append('noplainbuffer')
opt.splitbelow = true                         -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true                         -- Put new windows right of current
--opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
opt.tabstop = 2                               -- Number of spaces tabs count for
opt.softtabstop = 2
opt.shiftround = true                         -- Round indent
opt.shiftwidth = 2                            -- Size of an indent
opt.smartindent = true                        -- Insert indents automatically
opt.expandtab = true                          -- Use spaces instead of tabs

opt.termguicolors = true                      -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250               -- Save swap file and trigger CursorHold
opt.virtualedit = 'block'          -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winborder = 'rounded'          -- use rounded borders on all floating windows
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap

if vim.fn.has('nvim-0.10') == 1 then
  opt.smoothscroll = true
  -- opt.foldexpr = 'nvim_treesitter#foldexpr()'
  --opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = 'expr'
  opt.foldtext = ''
  -- opt.fillchars = 'diff:╱,eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
  opt.fillchars = ''
  -- opt.foldcolumn = '1'
  opt.foldcolumn = '0'
  opt.foldenable = true
  opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
  opt.foldlevel = 99
  opt.foldlevelstart = 99
  opt.foldnestmax = 3
  -- local function close_all_folds()
  --   vim.api.nvim_exec2('%foldc!', { output = false })
  -- end
  -- local function open_all_folds()
  --   vim.api.nvim_exec2('%foldo!', { output = false })
  -- end
  --
  -- vim.keymap.set('n', '<leader>zc', close_all_folds, { desc = '[c]lose all folds' })
  -- vim.keymap.set('n', '<leader>zo', open_all_folds, { desc = '[o]pen all folds' })
else
  opt.foldmethod = 'indent'
  opt.foldtext = 'vim.treesitter.foldtext' --"v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
