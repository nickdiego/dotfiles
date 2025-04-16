-- vim: et sw=2 tw=72 wrap
local lspconfig = require('lspconfig')
local telescope_builtin = require('telescope.builtin')

-- Keybindings

local gotodef = function(c)
  local split_cmd = (c.vertical) and 'vsplit' or 'split'
  vim.cmd(split_cmd)
  vim.lsp.buf.definition()
end

local on_attach = function(_, bufnr)
  local opts = function(extraopts)
    local default_opts = { noremap = false, silent = false, buffer = bufnr }
    for k, v in pairs(extraopts) do
      default_opts[k] = v
    end
    return default_opts
  end

  -- Jump to definition with "enter" or prefix it with 'v' or 's' for
  -- vertical or horizontal splits respectively.
  vim.keymap.set('n', '<cr>', function()
    telescope_builtin.lsp_definitions()
  end, opts {})
  vim.keymap.set('n', 'Ls<cr>', function() gotodef { vertical = false } end, opts {})
  vim.keymap.set('n', 'Lv<cr>', function() gotodef { vertical = true } end, opts {})

  -- List references with <backspace> or incoming calls with
  -- Alt+Backspace.
  vim.keymap.set('n', '<backspace>', function()
    telescope_builtin.lsp_references()
  end, opts { desc = 'LSP references (telescope)' })
  vim.keymap.set('n', '<A-backspace>', function()
    telescope_builtin.lsp_incoming_calls()
  end, opts { desc = 'LSP incoming calls (telescope)' })

  -- Ctrl+L to list document symbols
  vim.keymap.set('n', '<C-l>', function()
    telescope_builtin.lsp_document_symbols({ symbol_width = 0.8 })
  end, opts { desc = 'LSP Symbols (telescope)' })
  -- Ctrl+Alt+L to list workspace symbols
  vim.keymap.set('n', '<C-A-l>', function()
    telescope_builtin.lsp_workspace_symbols({ symbol_width = 0.8 })
  end, opts { desc = 'LSP wokspace Symbols (telescope)' })

  -- Other useful LSP keybindings.
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts {})
  vim.keymap.set('n', 'H', vim.lsp.buf.signature_help, opts {})
  vim.keymap.set('n', 'Rn', vim.lsp.buf.rename, opts {})
  vim.keymap.set({'n', 'v'}, 'Fm', function() vim.lsp.buf.format { async = true } end, opts {})
  vim.keymap.set({'n', 'v'}, 'gq', function() vim.lsp.buf.format { async = true } end, opts {})
  vim.keymap.set('n', 'Od', vim.diagnostic.open_float, opts { desc = 'LSP diagnostics' })
end

-- LSP configs

lspconfig.clangd.setup {
  cmd = { "clangd", "--background-index" },
  root_dir = lspconfig.util.root_pattern(".clangd", "compile_commands.json"),
  on_attach = on_attach,
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Add Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false, },
    },
  },
  on_attach = on_attach,
}

lspconfig.bashls.setup {
  on_attach = on_attach,
}

-- Diagnostic configs
vim.diagnostic.config({
  signs = false,
})

