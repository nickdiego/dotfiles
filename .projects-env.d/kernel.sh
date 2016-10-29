#!/bin/bash

# std project variables
projname='kernel'

setenv() {
  dirs[src]="$projroot/src/linux"
  defaultdir=root
  targets=('Linux-x86_64')
}

activate() {
  dirs[build]="$projroot/build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

