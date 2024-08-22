return {
  -- amongst your other plugins
  -- {'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    -- opts = {
    --[[ things you want to change go here]]
    require('toggleterm').setup {
      -- size can be a number or function which is passed the current terminal
      -- size = 20
      -- size = function(term)
      --   if term.direction == 'horizontal' then
      --     return 15
      --   elseif term.direction == 'vertical' then
      --     return vim.o.columns * 0.4
      --   end
      -- end,

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      open_mapping = [[<F7>]], -- [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
      on_close = function(t)   -- function to run when the terminal closes
        vim.cmd 'startinsert!'
      end,
      on_create = function(t) -- function to run when the terminal is first created
        vim.cmd 'startinsert!'
        local opts = { buffer = t.bufnr, noremap = true, silent = true }
        vim.keymap.set({ 'n', 't', 'i' }, '<esq><esq>', '<C-c><cmd>bd!<CR>', opts)
        vim.keymap.set({ 'n', 't' }, '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set({ 'n', 't' }, '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set({ 'n', 't' }, '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set({ 'n', 't' }, '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set({ 'n', 't' }, '<C-w>', [[<C-\><C-n><C-w>]], opts)
        -- vim.keymap.set({ 'n', 't', 'i' }, '<C-Up>', ':resize -2<CR>', opts)
        -- vim.keymap.set({ 'n', 't', 'i' }, '<C-Down>', ':resize +2<CR>', opts)
        -- vim.keymap.set({ 'n', 't', 'i' }, '<C-Left>', ':vertical resize -2<CR>', opts)
        -- vim.keymap.set({ 'n', 't', 'i' }, '<C-Right>', ':vertical resize +2<CR>', opts)
      end,
      --// on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_open = function(t)
      --   if t.direction == 'float' then
      --     return
      --   end
      --   local name = vim.fn.bufname 'neo-tree'
      --   local winnr = vim.fn.bufwinnr(name)
      --   if winnr ~= -1 then
      --     vim.defer_fn(function()
      --       local cmd = string.format 'Neotree toggle'
      --       vim.cmd(cmd)
      --       vim.cmd(cmd)
      --       vim.cmd 'wincmd p'
      --     end, 100)
      --   end
      -- end,
      --// on_close = fun(t: Terminal), -- function to run when the terminal closes
      --// on_stdout = fun(t: Terminal, job: number, data: string[], name: string), -- callback for processing output on stdout
      --// on_stderr = fun(t: Terminal, job: number, data: string[], name: string), -- callback for processing output on stderr
      --// on_exit = fun(t: Terminal, job: number, exit_code: number, name: string), -- function to run when terminal process exits
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},

      autochdir = false,        -- when neovim changes it current directory the terminal will change it's own when next it's opened
      shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
      shading_factor = -30,     -- the percentage by which to lighten dark terminal background, default: -30
      shading_ratio = -3,       -- the ratio of shading factor for light/dark terminal background, default: -3
      start_in_insert = true,
      insert_mappings = true,   -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
      direction = 'float',      -- 'horizontal', -- 'vertical' | | 'tab' | 'float',
      close_on_exit = false,    -- close the terminal window when the process exits
      -- Change the default shell. Can be a string or a function returning a string
      shell = vim.g.shell,
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' }, --'single', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
        -- calculate our floating window size
        width = math.ceil(vim.api.nvim_get_option_value('columns', {}) * 0.8 - 4),
        height = math.ceil(vim.api.nvim_get_option_value('lines', {}) * 0.8),
        -- and its starting position
        col = math.ceil((vim.api.nvim_get_option_value('columns', {}) - math.ceil(vim.api.nvim_get_option_value('columns', {}) * 0.8 - 4)) / 2 - 1),
        row = math.ceil((vim.api.nvim_get_option_value('lines', {}) - math.ceil(vim.api.nvim_get_option_value('lines', {}) * 0.8)) / 2),

        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
        winblend = 0,
        -- zindex = <value>,
        title_pos = 'center', -- | 'left' |  'right', position of the title of the floating window
      },
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          -- return fmt("%d:%s", term.id, term:_display_name())
          return term.name
        end,
      },
    }
    --}
  end,
}
