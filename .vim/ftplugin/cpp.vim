" ------------------------------------------------------------------------------
"
" Vim filetype plugin file
"
"   Language :  C / C++
"     Plugin :  c.vim (version 5.7)
" Maintainer :  Fritz Mehner <mehner@fh-swf.de>
"   Revision :  $Id: c.vim,v 1.44 2009/04/30 15:00:22 mehner Exp $
"
" ------------------------------------------------------------------------------
" ---------- C/C++ dictionary -----------------------------------
" This will enable keyword completion for C and C++
" using Vim's dictionary feature |i_CTRL-X_CTRL-K|.
"
if exists("g:C_Dictionary_File")
    silent! exec 'setlocal dictionary+='.g:C_Dictionary_File
endif
"
" configure tags
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
" build tags of your own project with CTRL+F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Setup tabstops to 4 and indents to 4
"set tabstop=4
set softtabstop=4
"set shiftwidth=4
set expandtab
set smarttab
"set autoindent

" line wrapping in python comments not python code
set textwidth=99       " Set the line wrap length

" C-mode formatting options
"   t auto-wrap comment
"   c allows textwidth to work on comments
"   q allows use of gq* for auto formatting
"   l don't break long lines in insert mode
"   r insert '*' on <cr>
"   o insert '*' on newline with 'o'
"   n recognize numbered bullets in comments
set formatoptions=tcqlron
