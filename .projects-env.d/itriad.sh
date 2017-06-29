#!/bin/bash

# std project variables
projname='itriad'
subprojects=('music-os' 'oma-dm')

setenv() {
  defaultdir=root
  case $subproj in
    music-os)
      dirs[src]="music/src/MusicOS"
      ;;
    oma-dm)
      dirs[src]="oma/src/android_packages_apps_OMA-DM"
      ;;
  esac
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r ${dirs[root]}/env.sh ] && . ${dirs[root]}/env.sh $target
}

