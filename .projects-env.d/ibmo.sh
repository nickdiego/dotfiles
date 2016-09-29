#!/bin/bash

# std project variables
projname='ibmo'
subprojects=('libibmo' 'ibmotool')

setenv() {
  local subproj=$1
  case $subproj in
    libibmo)
      srcdir="$projroot/src/ibmotool/libs/libibmo"
      targets=('Msys-x86_64' 'Linux-x86_64')
      ;;
    ibmotool)
      srcdir="$projroot/src/ibmotool"
      targets=('Msys-x86_64' 'Linux-x86_64')
      ;;
    *)
      return 1
      ;;
  esac
}

activate() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

