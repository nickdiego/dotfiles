-- vim: et sw=2

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      width = 0.6,
      height = 0.6,
      flip_columns = 150,
    },
    path_display = {
      'shorten',
    },
    winblend = 10,
  },
  preview = {
    -- Disable preview highlight for files >1MB.
    filesize_limit = 0.1,
  },
  mappings = {
    i = {
      ['<C-h>'] = 'which_key',
      ['<C-p>'] = 'cycle_history_previous',
      ['<C-j>'] = 'which_key',
      ['<C-k>'] = 'which_key',
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}

vim.keymap.set({ 'n', 'i' }, '<C-p>', builtin.git_files,
  {
    noremap = true,
    silent = true,
    desc = 'Git files (telescope)'
  })
vim.keymap.set({ 'n', 'i' }, '<C-k>', builtin.keymaps,
  {
    noremap = true,
    silent = true,
    desc = 'List keybindings (telescope)'
  })

telescope.load_extension('fzf')
