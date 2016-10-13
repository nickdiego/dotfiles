#!/bin/bash

# std project variables
projname='mingwtests'
projpath="$HOME/sandbox/mingw-tests"
subprojects=('helloqtquick')

setenv() {
  local subproj=$1
  case $subproj in
    'helloqtquick')
      srcdir="$projroot/hello-qt-quick"
      ;;
    *)
      srcdir="$projroot/$subproj"
      ;;
  esac
  targets=('Linux-x86_64' 'Msys-x86_64')
}

activate() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r $srcdir/env.sh ] && . $srcdir/env.sh $target
}

