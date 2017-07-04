#!/bin/bash

# std project variables
projname='oma'
subprojects=('moto-dm')

setenv() {
  defaultdir=root
  case $subproj in
    moto-dm)
      dirs[src]="src/android_packages_apps_OMA-DM"
      ;;
  esac
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r ${dirs[root]}/env.sh ] && . ${dirs[root]}/env.sh $target
}
