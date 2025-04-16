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
  { 'chromium/vim-codesearch' },
  { 'neovim/nvim-lspconfig' },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "vim", "python", "c", "cpp", "json", "html", "css" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
        fold = {
          enable = true,
        },
      }
    end
  },

  -- completion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-cmdline' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'onsails/lspkind.nvim' },
}
