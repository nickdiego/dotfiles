#!/bin/bash

# std project variables
projname='mingwtests'
projpath="$HOME/sandbox/mingw-tests"
subprojects=('helloqtquick')

setenv() {
  local subproj=$1
  srcdir="$projroot/$subproj"
  targets=('Linux-x86_64' 'Msys-x86_64')
}

activate() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

