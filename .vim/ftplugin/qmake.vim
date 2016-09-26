
" process only once
if exists("my_vim_qmake_vim_loaded") || &compatible
   finish
endif

let my_vim_qmake_vim_loaded = 1

" Setup tabstops to 4 and indents to 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
