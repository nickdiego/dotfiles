" High-level Settings
let g:custom_disable_arrow_keys = 0
let g:custom_space_instead_of_tab = 1
let g:custom_tabsize = 2
let g:custom_listchars = 0
let g:custom_cquery_cache_path = expand('~/.lsp/cquery-cache')
let g:custom_cquery_log_path = expand('~/.lsp/cquery.log')
let g:custom_pyls_log_path = expand('~/.lsp/pyls.log')
let g:custom_gols_log_path = expand('~/.lsp/go-langserver.log')
let g:custom_snippets_use_tab = 1

set hidden " Required by LanguageClient and Chromium Search plugins

if has('nvim')
    let g:custom_lsp_plugin = "LanguageClient"
else
    let g:custom_lsp_plugin = "vim-lsp"
endif

" Plugins configs
source ~/.vim/plugins.vim

let mapleader=","
set pastetoggle=<F2>
nnoremap ; :
imap jj <ESC>
nnoremap <space> za
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

set cursorline
set mouse=
set tabpagemax=15
set nowrap
set number
"set relativenumber
set noswapfile
set expandtab
set splitbelow
set splitright
set textwidth=79

"let g:loaded_python3_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:python2_host_prog = '/usr/bin/python2'

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

  let g:ale_sign_error = '⤫'
  let g:ale_sign_warning = '⚠'
  "let g:ale_set_quickfix = 1
  "let g:ale_open_list = 1

  " Enable integration with airline.
  let g:airline#extensions#ale#enabled = 1
  let g:ale_linters = {
  \   'gitcommit': ['gitlint'],
  \   'python': ['flake8'],
  \   'cpp': [],
  \   'c': ['clangtidy'],
  \}
  autocmd FileType gitcommit let g:ale_sign_column_always = 1
  "let g:ale_gitcommit_gitlint_options = '-C ~/.tcl-patcher/gitlint.ini'

  " Ctrl-j/k to navigate through ALI Errors/Warnings
  "nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  "nmap <silent> <C-j> <Plug>(ale_next_wrap)

  au FileType go :ALEEnable
" }

" vim-lsp configs {

if g:custom_lsp_plugin == "vim-lsp"

  let g:lsp_log_verbose = 0
  let g:lsp_log_file = expand('~/.lsp/vim-lsp.log')
  let g:asyncomplete_log_file = expand('~/.lsp/asyncomplete.log')

  if executable('cquery')
     au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery', '--log-file', g:custom_cquery_log_path]},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(
                \ lsp#utils#find_nearest_parent_file_directory(
                \ lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': g:custom_cquery_cache_path },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
  endif

  if executable('rustup')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable-x86_64-unknown-linux-gnu', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
  endif

  let g:autofmt_autosave = 1
  let g:lsp_signs_enabled = 1         " enable signs
  let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

  " LSP Keybindings
  nnoremap <Leader>rj :LspDefinition<CR>
  nnoremap <Leader>ri :LspImplementation<CR>
  nnoremap <Leader>rf :LspReferences<CR>
  " TODO add other Keybindings for vim/vim-lsp

else " LanguageClient_neovim

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  " cquery initialization options
  let cq_init_opts = '{"cacheDirectory":"'. g:custom_cquery_cache_path .'"}'

  let g:LanguageClient_autoStart = 0
  let g:LanguageClient_serverCommands = {
      \ 'c':      ['cquery', '--log-file', g:custom_cquery_log_path, '--init', cq_init_opts],
      \ 'cpp':    ['cquery', '--log-file', g:custom_cquery_log_path, '--init', cq_init_opts],
      \ 'go':     ['go-langserver', '-logfile', g:custom_gols_log_path],
      \ 'rust':   ['rustup', 'run', 'stable-x86_64-unknown-linux-gnu', 'rls'],
      \ 'python': ['pyls', '--log-file', g:custom_pyls_log_path],
      \ 'lua':    ['lua-lsp'],
      \ }

  let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
  let g:LanguageClient_settingsPath = expand('~/.config/nvim/settings.json')
  set completefunc=LanguageClient#complete
  set formatexpr=LanguageClient_textDocument_rangeFormatting()

  " LSP KeyBindings
  nnoremap <silent> <Leader>rj :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <Leader>rf :call LanguageClient_textDocument_references()<CR>
  nnoremap <silent> <Leader>rh :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> <Leader>rr :call LanguageClient_textDocument_rename()<CR>
  nnoremap <silent> <Leader>rs :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <silent> <Leader>ff :call LanguageClient_textDocument_formatting()<CR>

endif

" } LSP configs

" SimpleSnippets configs {

if !g:custom_snippets_use_tab
    let g:SimpleSnippets_dont_remap_tab = 0
    "let g:SimpleSnippetsExpandOrJumpTrigger = "<C-j>"
    "let g:SimpleSnippetsJumpBackwardTrigger = "<C-k>"
    let g:SimpleSnippetsJumpToLastTrigger = "<S-j>"
else
    " Disable supertab (?)
    let g:SimpleSnippets_dont_remap_tab = 1
    inoremap <silent><expr><Tab> pumvisible() ? "\<c-n>" :
        \SimpleSnippets#isExpandableOrJumpable() ?
        \"<Esc>:call SimpleSnippets#expandOrJump()<Cr>" :
        \"\<Tab>"
    inoremap <silent><expr><S-Tab> pumvisible() ? "\<c-p>" :
        \SimpleSnippets#isJumpable() ?
        \"<Esc>:call SimpleSnippets#jumpBackwards()<Cr>" :
        \"\<S-Tab>"
    inoremap <expr><Cr> pumvisible() ?
        \SimpleSnippets#isExpandableOrJumpable() ?
        \"\<Esc>:call SimpleSnippets#expandOrJump()\<Cr>" :
        \"\<Cr>" : "\<Cr>"
    snoremap <silent><expr><Tab> SimpleSnippets#isExpandableOrJumpable() ?
        \"<Esc>:call SimpleSnippets#expandOrJump()<Cr>" : "\<Tab>"
        snoremap <silent><expr><S-Tab> SimpleSnippets#isJumpable() ?
        \"<Esc>:call SimpleSnippets#jumpBackwards()<Cr>" :
        \"\<S-Tab>"
endif

" }

" Golang configs {

    au FileType go set noexpandtab
    au FileType go set shiftwidth=4
    au FileType go set softtabstop=4
    au FileType go set tabstop=4

    " Quickfix key mappings
    let g:go_list_type = "quickfix"
    let g:go_fmt_command = "goimports"
    let g:go_auto_sameids = 0
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1

    " run :GoBuild or :GoTestCompile based on the go file
    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction

    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nnoremap <Leader>a :GoAlternate<CR>
    au FileType go nmap <leader>gt :GoDeclsDir<cr>

    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

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
autocmd! BufWritePost .vimrc,*.vim source ~/.vimrc

" Quickfix bindings
map <C-j> :cnf<CR>
map <C-k> :cpf<CR>

" ff (normal mode) open CrSearch
let g:codesearch_source_root = '/home/nick/projects/chromium'
nnoremap ff :CrSearch<space>
nnoremap fx :CrXrefSearch<CR>

" Ctrl-f calls Ack.vim
nnoremap <C-F> :Ack!<space>
let g:ackprg = "ag --vimgrep"
let g:ackpreview = 1
let g:ack_autofold_results = 0

nnoremap <Leader>ff :Ack! <C-r><C-w>
nnoremap fv :vs<CR>:Ack! -w <C-r><C-w><CR>
nnoremap fh :sp<CR>:Ack -w <C-r><C-w><CR>

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

if g:custom_disable_arrow_keys
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
if g:custom_listchars
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

    " Enable relativenumber only in non-insert mode
    "augroup numbertoggle
        "autocmd!
        "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    "augroup END

    " Formatting {
        autocmd FileType Makefile set g:custom_space_instead_of_tab = 0
        if g:custom_space_instead_of_tab
"            set expandtab                    " tabs are spaces, not tabs"
        endif

        if !g:custom_tabsize
            let g:custom_tabsize = 4
        endif

        " number of spaces to use for each step of indent
        execute "set shiftwidth=".g:custom_tabsize
        " number of spaces that a <Tab> counts for
        execute "set tabstop=".g:custom_tabsize
        " let backspace delete indent
        execute "set softtabstop=".g:custom_tabsize

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


" denite {
    nnoremap <silent><leader>, :Denite file/rec buffer<CR>

" }

" new tests TODO {
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
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
