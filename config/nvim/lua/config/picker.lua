-- vim: et sw=2

vim.keymap.set({ 'n', 'i' }, '<C-p>', function() Snacks.picker.smart() end,
  { noremap = true, silent = true, desc = 'Open Files (snacks)' })
vim.keymap.set({ 'n', 'i' }, '<C-f>', function() Snacks.picker.grep() end,
  { noremap = true, silent = true, desc = 'Live grep (snacks)' })
vim.keymap.set({ 'n', 'i' }, '<C-A-k>', function() Snacks.picker.keymaps() end,
  { noremap = true, silent = true, desc = 'List keybindings (snacks)' })
vim.keymap.set({ 'n' }, '<Leader>r', function() Snacks.picker.resume() end,
  { noremap = true, silent = true, desc = 'Resume picker (snacks)' })
