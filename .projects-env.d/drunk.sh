#!/bin/bash

# std project variables
projname='drunk'
subprojects=('client' 'server')

setenv() {
  local subproj=$1
  targets=('Linux-x86_64' 'android_armv7')
  case $subproj in
    client)
      dirs[src]="src/qt-client-prototype"
      ;;
    server)
      dirs[src]="src/server-prototype"
      ;;
  esac
}

activate() {
  target=${targets[1]}

  local envscript="${projroot}/${dirs[src]}/env.sh"
  test -r $envscript && . $envscript $target

  local root=$(readlink -f $projroot)
  dirs[build]="${builddir#${root}/}"
}

