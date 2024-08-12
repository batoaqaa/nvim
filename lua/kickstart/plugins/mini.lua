return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup({ n_lines = 500 })
      --
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.pairs').setup({
        {
          modes = { insert = true, command = true, terminal = false },
          -- skip autopair when next character is one of these
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          -- skip autopair when the cursor is inside these treesitter nodes
          skip_ts = { "string" },
          -- skip autopair when next character is closing pair
          -- and there are more closing pairs than opening pairs
          skip_unbalanced = true,
          -- better deal with markdown code blocks
          markdown = true,
        },
        keys = {
          {
            "<leader>up",
            function()
              vim.g.minipairs_disable = not vim.g.minipairs_disable
              if vim.g.minipairs_disable then
                vim.notify(table.concat({ "OPtio: Disabled auto pairs" }, "\n"), vim.log.levels.WARN)
              else
                vim.notify(table.concat({ "OPtio: Enabled auto pairs" }, "\n"), vim.log.levels.WARN)
              end
            end,
            desc = "Toggle Auto Pairs",
          },
        },
        -- config = function(_, opts)
        --   LazyVim.mini.pairs(opts)
        -- end,
      })
      -- require('mini.bufremove').setup()
      --
      -- - ysaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - ysd'   - [S]urround [D]elete [']quotes
      -- - ysr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'ysa',            -- Add surrounding in Normal and Visual modes
          delete = 'ysd',         -- Delete surrounding
          find = 'ysf',           -- Find surrounding (to the right)
          find_left = 'ysF',      -- Find surrounding (to the left)
          highlight = 'ysh',      -- Highlight surrounding
          replace = 'ysr',        -- Replace surrounding
          update_n_lines = 'ysn', -- Update `n_lines`

          suffix_last = 'l',      -- Suffix to search with "prev" method
          suffix_next = 'n',      -- Suffix to search with "next" method
        },
      })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
