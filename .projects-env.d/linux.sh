#!/bin/bash

# std project variables
projname='linux'

setenv() {
  local root=$1
  srcdir="$root/src/linux"
  targets=('Linux-x86_64')
}

activate() {
  builddir=`readlink -f "$srcdir/../build/$target"`
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

