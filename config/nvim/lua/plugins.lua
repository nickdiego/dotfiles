-- vim: et ts=2 sw=2 ft=lua

vim.g.mapleader = ','

return {
  -- colorschemes
  {
    'chriskempson/base16-vim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      if vim.env.BASE16_THEME then
        local t = vim.env.BASE16_THEME
        if not vim.g.colors_name or vim.g.colors_name ~= 'base16-' .. t then
          vim.g.base16colorspace = 256
          vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)

          -- Fixups for base16 theme issues. TODO: Submit upstream.
          local t0 = vim.g.base16_cterm00
          local g0 = vim.g.base16_gui00
          vim.cmd('call Base16hi("LineNr", "", "' .. g0 .. '", "", "' .. t0 .. '", "", "")')
          vim.cmd('call Base16hi("PmenuSel", "", "", "", "", "none", "")')
        end
      end
    end,
  },

  -- general
  { 'vim-scripts/sessionman.vim' },

  -- navigation
  { 'christoomey/vim-tmux-navigator' },
  {
    'junegunn/fzf',
    build = ':fzf#install()',
    dependencies = { 'junegunn/fzf.vim' }
  },
  { 'junegunn/fzf.vim' },
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-ui-select.nvim' },



  -- status line
  { 'vim-airline/vim-airline' },
  { 'vim-airline/vim-airline-themes' },

  -- devtools
  { 'scrooloose/nerdcommenter' },
  { 'tpope/vim-fugitive' },
  { 'rhysd/committia.vim' },
  {
    'nickdiego/nvim-lspconfig',
    branch = 'gnls',
  },

  -- completion
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      -- cmp-cmdline leads to lots of random symbols when coding in
      -- C++ with clangd LSP. Disable for now.
      --'hrsh7th/cmp-cmdline',
    },
    config = function ()
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }
        })
      })
    end
  },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'onsails/lspkind.nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    version = '*',
    build = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        auto_install = false,
        ignore_install = { "javascript" },
        ensure_installed = { "cpp", "c", "bash", "lua", "vim", "gn", },
        modules = { "highlight", "fold", "locals", "textobjects", "incremental_selection" },
        highlight = { enable = true },
        locals = { enable = true },
        fold = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<bs>',
          },
        },
      }
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  },
}
