" process only once
if exists("my_vim_edje_vim_loaded") || &compatible
   finish
endif

let my_vim_edje_vim_loaded = 1

hi ErrorSpace cterm=NONE ctermfg=black   ctermbg=red
hi Error80    cterm=NONE ctermfg=yellow  ctermbg=NONE

au BufEnter * if &textwidth > 0 | exec 'match Error80 /\%>' . &textwidth . 'v.\+/' | endif
au BufEnter * exec 'syn match ErrorSpace /^ *\t\+\|[ \t]\+$/'
do BufEnter

set tabstop=3
set expandtab
