-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = function(mode, lhs, rhs, opts)
  local options = { silent = true } --noremap = true by default in vim.keymap.set
  if opts then
    options = vim.tbl_extend('force', options, opts or {})
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
-- Modes
-- <Space>	Normal, Visual, Select and Operator-pending
--  n  Normal
--  v  Visual and Select
--  s  Select
--  x  visual_block_mode
--  o  Operator-pending
--  !  Insert and Command-line
--  i  Insert
--  l  ":lmap" mappings for Insert, Command-line and Lang-Arg
--  c  Command-line
--  t  Terminal-Job
--  s   before the {rhs} a special character can appear:
--  *  indicates that it is not remappable
--  &  indicates that only script-local mappings are remappable
--  @  indicates a buffer-local mapping
--
--  C = Ctrl  <C-h>	= Ctrl+h
--  leader = Space
--  A = Alt   <A-j>	= Alt+j
--  S = Shift <S-j> = Shift+j

keymap('v', '/', '"fy/\\V<C-R>f<CR>')
keymap('v', '*', '"fy/\\V<C-R>f<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>')
keymap('n', '<C-Down>', ':resize +2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')

-- Naviagate buffers
-- keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Next Buffer' })
-- keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Prev Buffer' })
-- keymap('n', '<leader>bp', ':bprevious<CR>', { desc = '[P]revious Buffer' })
-- keymap('n', '<leader>bn', ':bn{{ desc = 'Next Buffer' } desc = 'Next Buffer' }{ desc = 'Next Buffer' }ext<CR>', { desc = '[N]ext Buffer' })
-- keymap('n', '<leader>bd', ':bdelete<CR>', { desc = '[D]elete Buffer' })
-- keymap('n', '<leader>bs', ':ball<CR>', { desc = '[S]how AllOpened Buffers' })
-- keymap('n', '[b', '<cmd>bnext<cr>', { desc = 'Prev Buf, { remap = false, silent = true }fer' })
-- keymap('n', ']b', '<cmd>bprevious<cr>', { desc = 'Next Buffer' })

keymap('n', '<leader>bb', ':bprevious<CR>', { desc = '[B]efore Buffer' })
keymap('n', '<leader>ba', ':bnext<CR>', { desc = '[A]fter Buffer' })
keymap('n', '<leader>bs', ':ball<CR>', { desc = '[S]how AllOpened Buffers' })
keymap('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle Pin' })
keymap('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = '[D]elete Buffer' })
keymap('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete Non-Pinned Buffers' })
keymap('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Delete Other Buffers' })
keymap('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete Buffers to the Right' })
keymap('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete Buffers to the Left' })
keymap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
keymap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
keymap('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
keymap('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
keymap('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer prev' })
keymap('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer next' })

-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==gi')

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>')
keymap('c', 'jk', '<ESC>')

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==')
keymap('v', '<A-k>', ':m .-2<CR>==')

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv")
keymap('x', 'K', ":move '<-2<CR>gv-gv")
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv")
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Command --
-- Menu navigation
keymap('c', '<C-j>', 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
keymap('c', '<C-k>', 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- vim.opt.hlsearch = true -- already assigned in options.lua
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch', -- see `:highlight` for more options
      timeout = 200,
    })
  end,
})
--
keymap({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yank' }) -- delete without yank
keymap({ 'n', 'v' }, '<leader>c', '"_c', { desc = 'Change text without yank' }) -- Change text without yank
-- keymap('x', 'p', 'pgv"+y', { desc = 'Paste and keep original yank in unnamed register' })
-- keymap('x', 'P', 'Pgv"+y', { desc = 'Paste and keep original yank in unnamed register' })

vim.keymap.set('x', 'p', '"_c<C-r>+<Esc>') -- replace-paste in insert mode
vim.keymap.set('x', 'P', '"_c<C-r>+<Esc>') -- replace-paste in insert mode
-- toggleterm keymaps
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

-- vim: ts=2 sts=2 sw=2 et
