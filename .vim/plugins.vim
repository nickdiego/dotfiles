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
Plugin 'Valloric/YouCompleteMe'
"Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
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
Plugin 'ensime/ensime-vim'

Plugin 'vim-airline/vim-airline-themes'

if has('nvim')
    Plugin 'vim-airline/vim-airline'
else
    Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
endif


"Plugin 'vim-airline/vim-airline'

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
