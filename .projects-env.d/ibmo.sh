#!/bin/bash

# std project variables
projname='ibmo'
subprojects=('libibmo' 'ibmotool')

setenv() {
  local subproj=$1
  targets=('Msys-x86_64' 'Linux-x86_64')
  case $subproj in
    libibmo)
      dirs[src]="src/ibmotool/libs/libibmo"
      ;;
    ibmotool)
      dirs[src]="src/ibmotool"
      ;;
  esac
}

activate() {
  dirs[build]="${dirs[src]}/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

