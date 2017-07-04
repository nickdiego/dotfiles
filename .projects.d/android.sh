#!/bin/bash

# std project variables
projname='android'

setenv() {
  #dirs[src]=""
  #targets=('Linux-x86_64')
  defaultdir=root
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

