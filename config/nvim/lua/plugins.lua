-- vim: et ts=2 sw=2 ft=lua

vim.g.mapleader = ','

return {
  -- colorschemes
  {
    'RRethy/base16-nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      if vim.env.BASE16_THEME then
        local t = 'base16-' .. vim.env.BASE16_THEME
        if not vim.g.colors_name or vim.g.colors_name ~= t then
          vim.cmd([[let base16colorspace=256]])
          vim.cmd('colorscheme ' .. t)
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

  -- bars/decorations
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function ()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start,
        { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

      -- Disable standard tabline to save some vertical space.
      vim.opt.showtabline = 0
    end
  },
  {
    'mawkler/modicator.nvim',
    dependencies = 'RRethy/base16-nvim',
    opts = {
      highlights = {
        defaults = { bold = true }
      }
    }
  },

  -- devtools
  { 'scrooloose/nerdcommenter' },
  { 'tpope/vim-fugitive' },
  { 'rhysd/committia.vim' },
  {
    'nickdiego/nvim-lspconfig',
    branch = 'gnls',
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require('config.snacks').options(),
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
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
