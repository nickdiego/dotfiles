-- vim: et sw=2
local lspconfig = require('lspconfig')

local gotodef_on_slit = function(c)
  local split_cmd = (c.vertical) and 'vsplit' or 'split'
  vim.cmd(split_cmd)
  vim.lsp.buf.definition()
end

local on_attach = function(_, bufnr)
  local bufopts = { noremap = false, silent = false, buffer = bufnr }

  -- Jump to definition with "enter" or prefix it with 'v' or 's' for
  -- vertical or horizontal splits respectively.
  vim.keymap.set('n', '<cr>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'Ls<cr>', function() gotodef_on_slit { vertical = false } end, bufopts)
  vim.keymap.set('n', 'Lv<cr>', function() gotodef_on_slit { vertical = true } end, bufopts)

  -- List references with <backspace> or incoming calls with
  -- Alt+Backspace.
  vim.keymap.set('n', '<backspace>', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<A-backspace>', vim.lsp.buf.incoming_calls, bufopts)

  -- Ctrl+L to list document symbols
  vim.keymap.set('n', '<C-l>', vim.lsp.buf.document_symbol, bufopts)

  -- Other useful LSP keybindings.
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'Rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'Fm', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', 'Od', vim.diagnostic.open_float, bufopts)
end

lspconfig.clangd.setup {
  cmd = { "clangd", "--background-index" },
  root_dir = lspconfig.util.root_pattern(".clangd", "compile_commands.json"),
  on_attach = on_attach,
}


