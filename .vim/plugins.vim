set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" my plugins
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/sessionman.vim'
"Plugin 'editorconfig/editorconfig-vim'
Plugin 'Shutnik/jshint2.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-pug'
Plugin 'peterhoeg/vim-qml'
Plugin 'wesQ3/vim-windowswap'
Plugin 'nanotech/jellybeans.vim'
Plugin 'roosta/srcery'
Plugin 'w0ng/vim-hybrid'
Plugin 'zeis/vim-kolor'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'
Plugin 'Yggdroot/indentLine'
Plugin 'tbastos/vim-lua'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'aklt/plantuml-syntax'
Plugin 'sickill/vim-monokai'
Plugin 'chriskempson/base16-vim'
Plugin 'hdima/python-syntax'
"Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'lyuts/vim-rtags'
Plugin 'nickdiego/ale'

Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'kelwin/vim-smali'

if has('nvim')
    Plugin 'ervandew/supertab'
    Plugin 'arakashic/chromatica.nvim'
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'zchee/deoplete-clang'
    Plugin 'Shougo/neoinclude.vim'

    let g:deoplete#enable_smart_case = 1
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
    "let b:deoplete_disable_auto_complete = 1

    " LanguageClient-nevim
    "Plugin 'autozimu/LanguageClient-neovim'
endif

"augroup omnifuncs
    "autocmd!
    "autocmd FileType java setlocal omnifunc=javacomplete#Complete
"augroup end

" temp enabled for nvim also (while
" deoplete doesn't support GoTo
" functionality. uncomment if later
if ! has('nvim')
    Plugin 'Valloric/YouCompleteMe'
    "Plugin 'scrooloose/syntastic'
endif

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
