#!/bin/bash

# std project variables
projname='ibmo'
subprojects=('libibmo' 'ibmotool')

setenv() {
  local subproj=$1
  case $subproj in
    ibmo)
      dirs[src]=$projroot
      ;;
    libibmo)
      dirs[src]="$projroot/src/ibmotool/libs/libibmo"
      ;;
    ibmotool)
      dirs[src]="$projroot/src/ibmotool"
      ;;
    *)
      return 1
      ;;
  esac
  targets=('Msys-x86_64' 'Linux-x86_64')
}

activate() {
  dirs[build]="${dirs[src]}/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

