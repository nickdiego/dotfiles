#!/bin/bash

# std project variables
projname='oma'
subprojects=('moto-dm' 'aosp')

setenv() {
  defaultdir=root
  case $subproj in
    moto-dm)
      dirs[src]="src/android_packages_apps_OMA-DM"
      ;;
    aosp)
      dirs[src]="src/aosp-src/aosp"
      options=(--docker)
      ;;
  esac
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  if [ "$subproj" = 'aosp' ] && (( ${_opt[--docker]} )); then
    ( cd "${dirs[root]}/${dirs[src]}/.." && \
        AOSP_IMAGE="kylemanna/aosp:5.0-lollipop" aosp; )
  fi

  # Call env initialization script if exists
  [ -r ${dirs[root]}/env.sh ] && . ${dirs[root]}/env.sh $target
}

