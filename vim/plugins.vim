call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/sessionman.vim'
Plug 'Shutnik/jshint2.vim'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-pug'
Plug 'peterhoeg/vim-qml'
Plug 'wesQ3/vim-windowswap'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'tbastos/vim-lua'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'aklt/plantuml-syntax'
Plug 'sickill/vim-monokai'
Plug 'chriskempson/base16-vim'
Plug 'w0rp/ale'
Plug 'junegunn/vader.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'kelwin/vim-smali'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'andreyorst/SimpleSnippets.vim'
Plug 'andreyorst/SimpleSnippets-snippets'
Plug 'chromium/vim-codesearch'
Plug 'kergoth/vim-bitbake'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/fzf.vim'

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': '/bin/bash install.sh'
        \ }
    Plug 'ervandew/supertab'
    Plug 'shougo/neoinclude.vim'
    Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

call plug#end()
