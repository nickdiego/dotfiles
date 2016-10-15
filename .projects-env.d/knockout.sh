#!/bin/bash

projname=knockout
subprojects=(scripts 3rdparty pic cc)

setenv() {
  local subproj=$1
  local srcbasedir="$projroot/repos/sunspot"
  srcdir=${srcbasedir}/${subproj}
  targets=('armv7a-mediatek482_001_neon-linux-gnueabi-strip')
  options=('--chroot' '--minicom')
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

  # Call env initialization script if exists
  [ -r $projroot/env.sh ] && . $projroot/env.sh $target

  # Process options
  if (( ${_opt[--chroot]} )); then
    echo "$subproj: chrooting..."
    chroot_precise64
  elif (( ${_opt[--minicom]} )); then
    local dev='/dev/ttyUSB0'
    echo "$subproj: connecting to ${dev}..."
    minicom -w -D $dev -b 115200
  fi
}

