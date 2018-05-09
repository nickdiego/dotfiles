" High-level Settings
let g:mdf_disable_arrow_keys = 0
let g:mdf_space_instead_of_tab = 1
let g:mdf_tabsize = 4
let g:mdf_listchars = 0

" Plugins configs
source ~/.vim/plugins.vim

let mapleader=","
set pastetoggle=<F2>
nnoremap ; :

set cursorline
set mouse=
set tabpagemax=15
set nowrap
set number
set noswapfile
set expandtab

" forcing 256 colors
set t_Co=256
set t_ut=

let g:indentLine_enabled = 1
let g:indentLine_char = '┆'

set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" NeoVim Configs {
if !has('nvim')
    set ttymouse=xterm2
endif

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

let g:powerline_pycmd = 'py3'
" }

"Powerline configs
let g:Powerline_symbols = 'fancy'

" Airline {
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#ycm#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='laederon'
"let g:airline_theme='hybrid'
"let g:airline_theme='minimalist'
let g:airline_theme='base16'
" }

" Leader-S to save as root (sudo tee trick)
nnoremap <leader>sw :w !sudo tee %<CR>

" Navigation + some general keybindings {
  nnoremap <C-Up> :tabprevious<CR>
  nnoremap <C-Down> :tabnext<CR>
  nnoremap <silent> <C-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
  nnoremap <silent> <C-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
  nnoremap <F5> :e!<CR>

  " Alt+<directional> to switch among splits
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <A-left> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-down> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-up> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-right> :TmuxNavigateRight<cr>
  nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
" }

"Eclim configs
let g:EclimCompletionMethod = 'omnifunc'

" ALE (Async Lint Engine) configs {
  let g:ale_enabled = 0
  let g:ale_set_loclist = 0
  let g:ale_sign_error = '!!'
  let g:ale_sign_warning = '>>'
  "let g:ale_set_quickfix = 1
  "let g:ale_open_list = 1
  let g:ale_linters = {
  \   'gitcommit': ['gitlint'],
  \   'python': ['flake8'],
  \   'cpp': [],
  \   'c': ['clangtidy'],
  \}
  autocmd FileType gitcommit let g:ale_sign_column_always = 1
  "let g:ale_gitcommit_gitlint_options = '-C ~/.tcl-patcher/gitlint.ini'

  " Ctrl-j/k to navigate through ALI Errors/Warnings
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }

" vim-lsp configs {
  if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
  endif

  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('~/.vim-lsp.log')
" }

set browsedir=current           " which directory to use for the file browser

set popt=left:8pc,right:3pc     " print options

if version >= 730 && version < 800
    if has("autocmd")
        " Autosave & Load Views.
        autocmd BufWritePost,WinLeave,BufWinLeave ?* if MakeViewCheck() | mkview | endif
        autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
    endif
else
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    if has("autocmd")
      autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    endif " has("autocmd")
endif

" When vimrc is edited, reload it
autocmd! BufWritePost .vimrc source ~/.vimrc

" Ctrl-Shift-f calls Ag.vim
nnoremap <C-F> :Ag<space>
" <leader>ag calls Ag.vim with the word under cursor
nnoremap <Leader>ag :Ag <C-r><C-w><C-m>

nnoremap <Leader>ss :%s,\<<C-r><C-w>\>,

" sessionman
nnoremap <Leader>SS :SessionSave<CR>


" Stupid shift key fixes
if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif
"cmap Tabe tabe

" syntastic stuff
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" YouCompleteMe stuff
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/custom/ycm_extra_conf.py'

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

if g:mdf_disable_arrow_keys
    " You want to be part of the gurus? Time to get in serious stuff and stop using
    " arrow keys.
    noremap <left> <nop>
    noremap <up> <nop>
    noremap <down> <nop>
    noremap <right> <nop>
endif
" }

if has('cmdline_info')
    set ruler                       " show the cursor position all the time
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids"
    set showcmd                     " display partial commands
endif

"set wildmenu                                        " command-line completion in an enhanced mode
"set wildmode=list:longest,full                      " command <Tab> completion, list matches, then longest common part, then all.
"set wildignore=*.bak,*.o,*.e,*~,*.obj,.git,*.pyc    " wildmenu: ignore these extensions
"
"set whichwrap=b,s,h,l,<,>,[,]                       " backspace and cursor keys wrap to
"
if g:mdf_listchars
    set list
    set listchars=tab:»·,trail:·,extends:#,nbsp:.       " strings to use in 'list' mode
endif



" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vimrc

" Editing {
    " Enable file type detection. Use the default filetype settings.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
        syntax on
    endif

    set backspace=indent,eol,start                  " backspacing over everything in insert mode

    set autoread                                    " auto reread file when changed outside Vim
    set autowrite                                   " write a modified buffer on each :next , ...

    "set complete+=k                                " scan the files given with the 'dictionary' option
    "set dictionary+=/usr/share/dict/words          " dictionary for word auto completion

    " Formatting {
        autocmd FileType Makefile set g:mdf_space_instead_of_tab = 0
        if g:mdf_space_instead_of_tab
"            set expandtab                    " tabs are spaces, not tabs"
        endif

        if !g:mdf_tabsize
            let g:mdf_tabsize = 4
        endif

        " number of spaces to use for each step of indent
        execute "set shiftwidth=".g:mdf_tabsize
        " number of spaces that a <Tab> counts for
        execute "set tabstop=".g:mdf_tabsize
        " let backspace delete indent
        execute "set softtabstop=".g:mdf_tabsize

        set autoindent                  " copy indent from current line
        set smartindent                 " smart autoindenting when starting a new line
    " }

    " Clipboard {
        set clipboard=unnamed
        "let @*=@a
    " }

    " Undo {
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif
    " }

    " Encoding {
        scriptencoding utf-8
        set encoding=utf-8              " Use UTF-8.
    " }

    " Searching {
        set hlsearch                    " highlight the last used search pattern
        set incsearch                   " do incremental searching
        set ignorecase                  " Ignore case when searching.
        set smartcase                   " case-sensitive if search contains an uppercase character

        " clearing highlighted search
        noremap <leader><space> :noh<cr>:call clearmatches()<cr>
    " }
" }

    " Folding {
        " Enable folding, but by default make it act like folding is off, because
        " folding is annoying in anything but a few rare cases
        set foldenable                          " Turn on folding
        set foldmethod=indent                   " Make folding indent sensitive
        set foldlevel=100                       " Don't autofold anything (but I can still fold manually)
        set foldopen-=search                    " don't open folds when you search into them
        set foldopen-=undo                      " don't open folds when you undo stuff
    " }

    if has('statusline')
        set laststatus=2
        "set statusline=[%{&ff}]\ [%Y]\ [pos:%04l,%04v][%p%%]\ [len:%L]\ %<%F%m%r%h%w

        " Broken down into easily includeable segments
        set statusline=%<%f\                        " Filename
        set statusline+=%w%h%m%r                    " Options
        set statusline+=%{fugitive#statusline()}    " Git Hotness
        set statusline+=\ [%{&ff}/%Y]               " filetype
        "set statusline+=\ [%{getcwd()}]             " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%     " Right aligned file nav info

    endif

    " from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    if has("autocmd")
        highlight ExtraWhitespace ctermbg=red guibg=red
        match ExtraWhitespace /\s\+$/
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        autocmd BufWinLeave * call clearmatches()
    endif

" Filetype actions {
    if has("autocmd")
        autocmd BufNewFile,BufRead *.aidl  set filetype=java
        autocmd BufNewFile,BufRead *.qbs  set filetype=qml
    endif
" }

" NerdTree {
    "map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.bak', '\.o', '\.e', '\.obj']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
" }

" ctrlp {
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    "let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_working_path_mode = '' "will use the current PWD
    set wildignore+=LayoutTests/,PerformanceTests/,Websites/,*.un~'
    let g:ctrlp_root_markers = ['.git', '.repo', '.pro', 'package.json', 'build.xml', 'main.ncl' ]
    let g:ctrlp_custom_ignore = {
        \ 'dir': '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.class' }
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'ag %s -l --nocolor --hidden -g "" --ignore node_modules --ignore bower_components'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'find %s -type f | grep "\.cpp\$\|\.h\$\|\.cmake\$\|\.messages.in\$\|.txt\|\.js\|\.json\$\|\.java\$\|\.smali\$"'
    \ }
"}

" YouCompleteMe {
    nnoremap <Leader>d :YcmCompleter GoTo<CR>
    nnoremap <Leader>h :YcmCompleter GoToInclude<CR>
    nnoremap <Leader>t :YcmCompleter GetType<CR>
    "not supported for C/C++ :(
    nnoremap <Leader>r :YcmCompleter GoToReferences<CR>
" }

" new tests TODO {
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    let g:chromatica#enable_at_startup=1
    let g:chromatica#libclang_path = '/usr/lib/libclang.so'
    let g:chromatica#responsive_mode=1
" }

" compile all sources as c++11 (just for example, use .clang_complete for
"  " setting version of the language per project)
let g:clang_user_options = '-std=c++11'

" Eclim {
    nnoremap <Leader>ji :JavaImport<CR>

" }

" Python-specifc stuff {
    let python_highlight_all = 1
" }
