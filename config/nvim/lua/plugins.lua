-- vim: et ts=2 sw=2 ft=lua

return {
  -- colorschemes
  {
    'chriskempson/base16-vim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      if vim.env.BASE16_THEME then
        local t = vim.env.BASE16_THEME
        if not vim.g.colors_name or vim.g.colors_name ~= 'base16-' .. t then
          vim.g.base16colorspace = 256
          vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)

          -- Fixups for base16 theme issues. TODO: Submit upstream.
          local t0 = vim.g.base16_cterm00
          vim.cmd('call Base16hi("LineNr", "", "", "", ' .. t0 .. ', "", "")')
          vim.cmd('call Base16hi("PmenuSel", "", "", "", "", "none", "")')
        end
      end
    end,
  },

  -- general
  { 'vim-scripts/sessionman.vim' },
  { 'christoomey/vim-tmux-navigator' },
  {
   'junegunn/fzf',
    build = ':fzf#install()',
    dependencies = { 'junegunn/fzf.vim' }
  },
  { 'junegunn/fzf.vim' },

  -- status line
  { 'vim-airline/vim-airline' },
  { 'vim-airline/vim-airline-themes' },

  -- devtools
  { 'tpope/vim-fugitive' },
  { 'rhysd/committia.vim' },
  { 'chromium/vim-codesearch' },

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
