#!/bin/bash

# std project variables
projname='ibmo'
subprojects=('libibmo' 'ibmotool')

setenv() {
  local subproj=$1
  case $subproj in
    ibmo)
      srcdir=$projroot
      ;;
    libibmo)
      srcdir="$projroot/src/ibmotool/libs/libibmo"
      ;;
    ibmotool)
      srcdir="$projroot/src/ibmotool"
      ;;
    *)
      return 1
      ;;
  esac
  targets=('Msys-x86_64' 'Linux-x86_64')
}

activate() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

