-- to disable netrw entirely
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Toggle virtual_text off when on the line with the error
vim.diagnostic.config({
  -- virtual_text = true,
  virtual_text = { spacing = 4, prefix = '●' },
  -- virtual_lines = { current_line = true },
  virtual_lines = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
})

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require('options')

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
require('lazy-bootstrap')

-- [[ Configure and install plugins ]]
require('lazy-plugins')

local group = vim.api.nvim_create_augroup('rlnum', { clear = true })
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = { '*:i*', 'i*:*' },
  group = group,
  callback = function()
    vim.o.relativenumber = vim.api.nvim_get_mode().mode:match('^i') == nil
  end,
})
------------------------
------------------------
-- Ensure you have toggleterm installed and set up
-- This is a conceptual example. You might integrate this into mappings or functions.

-- Get the toggleterm module
local Terminal = require('toggleterm.terminal').Terminal

-- Option 1: Define a new terminal instance (or get it if it already exists with this config)
-- We give it an ID so we can refer to it later.
local my_term = Terminal:new({
  id = 'my_persistent_term', -- A unique ID for this terminal
  hidden = true,             -- Start hidden, we'll open it explicitly
  direction = 'tab',         -- Or 'horizontal', 'vertical', 'tab'
  -- You can add other toggleterm options here:
  -- on_open = function(term)
  --   vim.cmd("setlocal norelativenumber")
  -- end,
  -- size = function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  -- float_opts = {
  --   border = 'curved',
  -- }
})

-- Function to open the terminal if it's not already open
function OpenMyTerminal()
  if not my_term:is_open() then
    my_term:open()
    print("ToggleTerm 'my_persistent_term' opened.")
  else
    -- If you want to toggle it (open if closed, close if open), you can use:
    -- my_term:toggle()
    -- For this example, we just ensure it's open.
    print("ToggleTerm 'my_persistent_term' is already open.")
  end
end

-- Function to send commands to our terminal
-- It will open the terminal if it's not already open.
function SendCommandToMyTerminal(command)
  if not command or command == '' then
    print('No command provided.')
    return
  end

  OpenMyTerminal() -- Ensure it's open

  -- Small delay to ensure the terminal is ready, especially if just opened.
  -- This might not always be necessary but can help with reliability.
  -- You might need to adjust the delay or use a more robust check if issues arise.
  vim.defer_fn(function()
    my_term:send(command, false) -- Send the command, false means don't add <CR> automatically
    my_term:send('', true)       -- Send an Enter key press to execute the command
    print('Sent command: ' .. command)

    -- If you want to bring focus to the terminal after sending a command:
    -- vim.cmd("ToggleTerm " .. my_term.id) -- This re-toggles, effectively focusing
    -- Or, more directly if you want to ensure it's focused without toggling visibility:
    -- if my_term:is_open() and my_term.window then
    --   vim.api.nvim_set_current_win(my_term.window)
    -- end
  end, 50) -- 50ms delay, adjust as needed
end

-- Example Usage:

-- 1. Open the terminal (if not already open)
-- OpenMyTerminal()

-- 2. Send some commands
-- You can call this function multiple times.
-- SendCommandToMyTerminal("ls -la")
-- SendCommandToMyTerminal("echo 'Hello from Neovim!'")
-- SendCommandToMyTerminal("pwd")

-- You can map these functions to keys:
vim.keymap.set('n', '<leader>to', OpenMyTerminal, { noremap = true, silent = true, desc = 'Open My Persistent Terminal' })
vim.keymap.set('n', '<leader>ts', function()
  local cmd = vim.fn.input('Cmd to send: ')
  SendCommandToMyTerminal(cmd)
end, { noremap = true, silent = true, desc = 'Send command to My Terminal' })

-- To use an existing default toggleterm (if you haven't defined one like above)
-- You might need to find its ID or use the general toggleterm commands.
-- For a more generic approach if you just want to use THE current/default toggleterm:

local tt = require('toggleterm')

function OpenDefaultToggleTermAndSendCommand(command)
  if not command or command == '' then
    print('No command provided.')
    return
  end

  -- This will open the default terminal or the last used one.
  -- It doesn't give as much control as having a specific Terminal object.
  tt.toggle(0, nil, nil, nil) -- Open/toggle the default terminal

  vim.defer_fn(function()
    -- Finding the active ToggleTerm to send commands to it can be tricky
    -- if you don't have a direct reference to the Terminal object.
    -- The `my_term:send()` approach is more reliable.
    --
    -- If you absolutely must use the generic toggle and then send,
    -- you might need to iterate through `require('toggleterm.state').get_config_managers()`
    -- to find the active one, which is more complex.
    --
    -- For simplicity with generic toggle, often people map keys to send
    -- commands directly when the terminal is already focused, or use
    -- `vim.fn.termopen()` and manage it more manually if not using ToggleTerm's object model.

    -- A more direct way if you have a *known* terminal ID you want to target after generic toggle
    local target_term_id           -- You'd need to know this or determine it
    if my_term and my_term.id then -- Using the previously defined one as an example
      target_term_id = my_term.id
    end

    if target_term_id then
      local term_to_send_to = Terminal:get(target_term_id)
      if term_to_send_to and term_to_send_to:is_open() then
        term_to_send_to:send(command, false)
        term_to_send_to:send('', true)
        print('Sent command (to id ' .. target_term_id .. '): ' .. command)
      else
        print('Could not find or terminal (id ' .. target_term_id .. ') is not open to send command.')
      end
    else
      print('Cannot reliably send command after generic toggle without a specific terminal reference or ID.')
      print('Consider using the Terminal object approach (my_term) for sending commands.')
    end
  end, 100) -- Increased delay for generic toggle
end

-- Example with generic toggle (less reliable for sending commands without specific term object):
-- vim.keymap.set('n', '<leader>tx', function()
--   local cmd = vim.fn.input('Cmd to send (generic): ')
--   OpenDefaultToggleTermAndSendCommand(cmd)
-- end, { noremap = true, silent = true, desc = 'Send command to Default Terminal' })

print('ToggleTerm persistent terminal functions loaded. Try <leader>to and <leader>ts (if mapped).')
------------------------
------------------------
-- [[ Configure python env ]]
require('pynvim')
------------------------
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
