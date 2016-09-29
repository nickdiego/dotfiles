#!/bin/bash

projname=knockout
subprojects=(cc pic)

setenv() {
  local subproj=$1
  local srcbasedir="$projroot/repos/sunspot"
  srcdir=${srcbasedir}/${subproj}
  targets=('armv7a-mediatek482_001_neon-linux-gnueabi-strip')
}

activate() {
  function chroot_precise64() {
    echo "Entering Knockout chroot environment..."
    schroot -c precise64 -u nick
    set-window-title "$PWD"
  }

  builddir="$projroot/build/$target" #TODO
  target=${targets[0]} # FIXME get from parameters

  local opt_chroot=0
  while (( $# )); do
    case $1 in
      --chroot) opt_chroot=1 ;;
    esac
    shift
  done
  (( opt_chroot )) && echo "chroo??"

  # TODO Call come env initialization script
}

