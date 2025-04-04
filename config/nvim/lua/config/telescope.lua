-- vim: et sw=2

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

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
    i = { ['<C-h>'] = actions.which_key }
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
vim.keymap.set({ 'n', 'i' }, '<C-A-p>', builtin.resume,
  {
    noremap = true,
    silent = true,
    desc = 'Latest picker (telescope)'
  })
vim.keymap.set({ 'n', 'i' }, '<C-A-o>', function()
    builtin.buffers({
      sort_mru = true,
      ignore_current_buffer = true,
    })
    vim.api.nvim_input('<Esc>')
  end,
  {
    noremap = true,
    silent = true,
    desc = 'Vim buffers (telescope)'
  })
vim.keymap.set({ 'n', 'i' }, '<C-A-k>', builtin.keymaps,
  {
    noremap = true,
    silent = true,
    desc = 'List keybindings (telescope)'
  })

telescope.load_extension('fzf')
