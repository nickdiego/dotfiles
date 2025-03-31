-- vim: et ts=2 sw=2 ft=lua

vim.lsp.config = {
  clangd = {
    cmd = { 'clangd', '-j', '4' },
    filetypes = { 'c', 'cpp' },
    root_markers = { 'compile_commands.json', '.gn', '.clangd' }
  },
  gnls = {
    cmd = { 'gnls', '--stdio' },
    filetypes = { 'gn' },
    root_markers = { '.gn' }
  },
  luals = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'lazy-lock.json' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        }
      }
    }
  },
  pyls = {
    cmd = { 'pylsp', '--log-file', vim.fn.stdpath('state') .. '/pylsp.log' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py' }
  },
  bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh' },
  },
}

vim.lsp.enable('clangd')
vim.lsp.enable('gnls')
vim.lsp.enable('luals')
vim.lsp.enable('pyls')
vim.lsp.enable('bashls')

