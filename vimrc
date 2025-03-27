" vim: et ts=2 sw=2 ft=vim

" Basic options. Keep them before loading plugins.
set hidden              " Allow to switch buffers without saving
set number              " Show line numbers
set cursorline          " Highlight cursor line
set mouse=              " Disable mouse
set nowrap              " Do not wrap text
set splitbelow          " Open hsplits below
set splitright          " Open vsplits at right
set scrolloff=999       " Keep cursorline mostly in the middle of the screen
set autoindent          " Copy indent from current line
set smartindent         " Smart autoindenting when starting a new line
set noswapfile          " Disable swap files by default.
set textwidth=72        " Default text width.
set tabpagemax=15       " Set a max number of tabs
set background=dark     " Prefer dark colors
set browsedir=current   " Use current directory for file browser
set hlsearch            " Highlight the last used search pattern
set incsearch           " Do incremental searching
set nojoinspaces        " Only one space are added when joining lines
set ignorecase          " Ignore case when searching
set smartcase           " Case-sensitive if any uppercase char
set nowrapscan          " Do not wrap around when searching
set foldenable          " Turn on folding
set foldmethod=indent   " Make folding indent sensitive
set foldlevel=100       " Do not autofold anything
set foldopen-=search    " Do not open folds when you search into them
set foldopen-=undo      " Do not open folds when you undo stuff

" Load plugins
source ~/.vim/plugins.vim

" Enconding
scriptencoding utf-8
set encoding=utf-8

if has('persistent_undo')
  set undofile                " Enable persistent undo history
  set undolevels=1000         " Max number of changes that can be undone
  set undoreload=10000        " Max number lines to save for undo on a buffer reload
endif

" Basic key bindings
let mapleader=","
" Indent (keeping in visual mode)
vnoremap > >gv
" Deindent (keeping in visual mode)
vnoremap < <gv
" Space to fold/unfold in normal mode
nnoremap <space> za
" Clear highlighted search
nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Leader-ss to find/replace word under cursor
nnoremap <leader>ss :%s,\<<C-r><C-w>\>,
" Leader-sw to save as root
nnoremap <leader>sw :w !sudo tee %<CR>
" F5 to reload file from disk
nnoremap <silent><F5> :e!<CR>

" Other custom settings
let g:disable_arrow_keys = 1
let g:use_space_instead_of_tabs = 1
let g:default_tabsize = 2
let g:lsp_pyls_log_path = expand('~/.lsp/pyls.log')
let g:lsp_gols_log_path = expand('~/.lsp/go-langserver.log')

if has('cmdline_info')
    set ruler                       " show the cursor position all the time
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids"
    set showcmd                     " display partial commands
endif

" Editing configs
set backspace=indent,eol,start                  " backspacing over everything in insert mode
set autoread                                    " auto reread file when changed outside Vim
set autowrite                                   " write a modified buffer on each :next, etc.
filetype plugin indent on
if g:disable_arrow_keys
  noremap <left> <nop>
  noremap <up> <nop>
  noremap <down> <nop>
  noremap <right> <nop>
endif

augroup numbertoggle  " Enable relativenumber only in non-insert mode
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd FileType Makefile set g:use_space_instead_of_tabs = 0
if g:use_space_instead_of_tabs
  set expandtab                    " tabs are spaces, not tabs"
endif

if !g:default_tabsize
  let g:default_tabsize = 4
endif

" number of spaces to use for each step of indent
execute "set shiftwidth=".g:default_tabsize
" number of spaces that a <Tab> counts for
execute "set tabstop=".g:default_tabsize
" let backspace delete indent
execute "set softtabstop=".g:default_tabsize

" Status line config
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\                        " Filename
  set statusline+=%w%h%m%r                    " Optios
  set statusline+=%{fugitive#statusline()}    " Git Hotness
  set statusline+=\ [%{&ff}/%Y]               " filetype
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

if has("autocmd")
  autocmd BufNewFile,BufRead *.aidl  set filetype=java
  autocmd BufNewFile,BufRead *.qbs  set filetype=qml
endif

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

" Python interpreter settings
let g:python3_host_prog = '/bin/python3'
let g:python2_host_prog = '/bin/python2'

" Syntax highlight and colorscheme setup
" Enable syntax highlight when the env supports it and
" loads base16 settings if any.
if &t_Co > 2 || has("gui_running")
  " Force 256 colors
  set t_Co=256
  set t_ut=

  " Switch syntax highlighting on
  syntax on

  set termguicolors

  " Base16 customizations
  function! s:base16_customize() abort
    call Base16hi("LineNr", "", "", "", g:base16_cterm00, "", "")
  endfunction
  augroup on_change_colorschema
    autocmd!
    autocmd ColorScheme base16-* call s:base16_customize()
  augroup END

endif

  " Load from the shell, if any.
  if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
  endif

" Vim-specifics (too old?)
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

" NeoVim-specifics
if !has('nvim')
    set ttymouse=xterm2
endif
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Airline configs
let g:airline_section_b = 0
let g:airline_section_y = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16'

" Navigation-related keybindings
nnoremap <silent> <C-j> :tabprevious<CR>
nnoremap <silent> <C-k> :tabnext<CR>
if !g:disable_arrow_keys
  nnoremap <silent> <C-Up> :tabprevious<CR>
  nnoremap <silent> <C-Down> :tabnext<CR>
endif
" TODO: find alt for these ones, <C-L> already used for LPS commands
nnoremap <silent> <C-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

  " Alt+<directional> to switch among splits
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
if !g:disable_arrow_keys
  nnoremap <silent> <A-left> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-down> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-up> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-right> :TmuxNavigateRight<cr>
endif

" ALE (Async Lint Engine) configs {
let g:ale_enabled = 0
let g:ale_set_loclist = 0
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1  " Enable integration with airline.
let g:ale_linters = {
      \   'gitcommit': ['gitlint'],
      \   'python': ['flake8'],
      \   'cpp': [],
      \   'c': ['clangtidy'],
      \}
autocmd FileType gitcommit let g:ale_sign_column_always = 1

augroup gn_ft
  au!
  autocmd BufNewFile,BufRead *.gn set filetype=gn syntax=python
  autocmd BufNewFile,BufRead *.gni set filetype=gn syntax=python
augroup END

" LSP configs
if g:lsp_plugin == "LanguageClient" && has('nvim')

  let g:LanguageClient_serverStderr = '/tmp/lsp.stderr'
  let g:LanguageClient_echoProjectRoot = 1
  let g:LanguageClient_diagnosticsEnable = 0
  let g:LanguageClient_autoStart = 0
  let g:LanguageClient_serverCommands = {
        \ 'c':      ['clangd', '-j=4'],
        \ 'cpp':    ['clangd', '-j=4'],
        \ 'go':     ['go-langserver', '-logfile', g:lsp_gols_log_path],
        \ 'rust':   ['rustup', 'run', 'stable-x86_64-unknown-linux-gnu', 'rls'],
        \ 'python': ['pylsp', '--log-file', g:lsp_pyls_log_path],
        \ 'lua':    ['lua-lsp'],
        \ 'java':   ['jdtls', '-data', getcwd()],
        \ 'sh':     ['bash-language-server', 'start'],
        \ 'gn':     ['gnls', '--stdio'],
        \ }
  " deoplete configs
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option({
        \ 'auto_complete_delay': 100,
        \ 'smart_case': v:true,
        \ })

  " LSP key bindings
  function SetupLSP()
    nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
    nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
    nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
    nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
    nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
    nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    nnoremap <leader>lw :call LanguageClient#workspace_symbol()<CR>
    " Common shortcuts
    " Whoaaa? enter => jump to definition" ? yes! :D
    nnoremap <C-l> :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <CR> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <M-CR> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
    nnoremap <Backspace> :call LanguageClient#textDocument_references()<CR>

    set completefunc=LanguageClient#complete
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
  endfunction()

  augroup LSP
    autocmd!
    autocmd FileType cpp,c,python,java,gn,sh call SetupLSP()
    autocmd FileType cpp,c,python,java,gn,sh LanguageClientStart
  augroup END
endif

" Supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" FZF configs
noremap <C-p> :GFiles<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>o :History<CR>
nnoremap <leader>c :Commits<CR>
nnoremap <leader>h :Helptags<CR>

" With fzf open, make Ctrl+P and Ctrl-N navigate throught the history
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~20%' }

" Customize fzf colors to match current color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Auto-hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Golang configs
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

" cpp-enhanced-hightlight options:
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_template_highlight = 1
