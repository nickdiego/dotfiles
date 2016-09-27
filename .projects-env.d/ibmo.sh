#!/bin/bash

# std project variables
projname='ibmo'
subprojects=('libibmo' 'ibmotool')

setenv() {
  local root=$1 subproj=$2
  case $subproj in
    libibmo)
      srcdir="$root/src/ibmotool/libibmo"
      targets=('Msys-x86_64' 'Linux-x86_64')
      ;;
    ibmotool)
      srcdir="$root/src/ibmotool"
      targets=('Msys-x86_64' 'Linux-x86_64')
      ;;
    *)
      return 1
      ;;
  esac
}

activate_libibmo() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters
}

activate_ibmotool() {
  builddir="$srcdir/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

