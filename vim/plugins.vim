" vim: et ts=2 sw=2 ft=vim

" Plugin loading related configs
let g:lsp_plugin = "LanguageClient"

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/sessionman.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" color schemes
Plug 'chriskempson/base16-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'

" lang support
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-pug'
Plug 'peterhoeg/vim-qml'
Plug 'tbastos/vim-lua'
Plug 'aklt/plantuml-syntax'
Plug 'junegunn/vader.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'kelwin/vim-smali'
Plug 'kergoth/vim-bitbake'

" devtools
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'chromium/vim-codesearch'
Plug 'scrooloose/nerdcommenter'

call plug#end()
