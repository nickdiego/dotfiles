local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
  cmd = { "clangd", "--background-index" }, -- Start clangd with background indexing enabled
  root_dir = lspconfig.util.root_pattern( ".clangd", "compile_commands.json"),
}


