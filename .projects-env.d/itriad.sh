#!/bin/bash

# std project variables
projname='itriad'
subprojects=('udacity')

setenv() {
  #dirs[src]=""
  #targets=('Linux-x86_64')
  defaultdir=root
  case $subproj in
    udacity)
      dirs[src]="android-study/udacity/devel-android-apps"
      ;;
  esac
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r ${dirs[root]}/env.sh ] && . ${dirs[root]}/env.sh $target
}

