
" process only once
"if exists("my_vim_python_vim_loaded") || &compatible
"   finish
"endif

"let my_vim_python_vim_loaded = 1

" Setup tabstops to 4 and indents to 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

" line wrapping in python comments not python code
set textwidth=79       " Set the line wrap length

" C-mode formatting options
"   t auto-wrap comment
"   c allows textwidth to work on comments
"   q allows use of gq* for auto formatting
"   l don't break long lines in insert mode
"   r insert '*' on <cr>
"   o insert '*' on newline with 'o'
"   n recognize numbered bullets in comments
set formatoptions=tcqlron

" Extra syntax
hi ErrorSpace cterm=NONE ctermfg=black   ctermbg=red
hi Error80    cterm=NONE ctermfg=yellow  ctermbg=NONE

au BufEnter * if &textwidth > 0 | exec 'match Error80 /\%>' . &textwidth . 'v.\+/' | endif
"au BufEnter * exec 'syn match ErrorSpace /^\t* \+\|[ \t]\+$/'
au BufEnter * exec 'syn match ErrorSpace /[ \t]\+$/'
do BufEnter

syn keyword pythonStatement None
