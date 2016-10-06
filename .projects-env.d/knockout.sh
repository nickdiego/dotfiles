#!/bin/bash

projname=knockout
subprojects=(scripts cc pic)

setenv() {
  local subproj=$1
  local srcbasedir="$projroot/repos/sunspot"
  srcdir=${srcbasedir}/${subproj}
  targets=('armv7a-mediatek482_001_neon-linux-gnueabi-strip')
  options=('--chroot')
}

activate() {
  local subproj=$1

  function chroot_precise64() {
    echo "Entering Knockout chroot environment..."
    schroot -c precise64 -u nick
    set-window-title "$PWD"
  }

  builddir="$projroot/build/$target" #TODO
  target=${targets[0]} # FIXME get from parameters

  if (( ${_opt[--chroot]} )); then
    echo "$subproj: chrooting..."
    chroot_precise64
  fi

  # TODO Call come env initialization script
}

