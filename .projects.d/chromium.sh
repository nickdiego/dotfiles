#!/bin/bash

# std project variables
projname='chromium'

setenv() {
  dirs[src]="src/chromium"
  defaultdir=root
  targets=('Linux-x86_64')
}

activate() {
  dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

