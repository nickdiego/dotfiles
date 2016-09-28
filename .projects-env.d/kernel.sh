#!/bin/bash

# std project variables
projname='kernel'

setenv() {
  projroot=$1
  srcdir="$projroot/src/linux"
  targets=('Linux-x86_64')
}

activate() {
  builddir="$projroot/build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

