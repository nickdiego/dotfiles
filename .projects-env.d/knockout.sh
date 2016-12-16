#!/bin/bash

projname=knockout
subprojects=(scripts 3rdparty pic cc ncl)

setenv() {
  local subproj=$1
  targets=('knockout' 'x86')
  options=('--chroot' '--minicom' '--emulator')
  dirs[sunspot]='repos/sunspot'

  target=${targets[0]}

  if [[ $subproj == $projname ]]; then
    defaultdir=sunspot
  else
    dirs[src]="repos/sunspot/${subproj}"
    defaultdir=src
  fi
}

activate() {
  local subproj=$1

  function chroot_precise64() {
    local label='precise64'
    local title="chroot [${label}]"
    echo "Entering Knockout chroot environment '$label'..."
    set-window-title "$title"
    schroot -c precise64 -u nick
  }

  (( ${_opt[--emulator]} )) && target=${targets[1]} || target=${targets[0]}

  dirs[precompiled]="repos/sunspot/precompiled/arch/$target"
  dirs[sandbox]="repos/sunspot/precompiled/arch/$target/sandbox"

  dirs[build]="build/$target" #TODO

  # Call env initialization script if exists
  [ -r $projroot/repos/sunspot/env.sh ] &&
    . $projroot/repos/sunspot/env.sh $target

  # Process options
  if (( ${_opt[--chroot]} )); then
    echo "$subproj: chrooting..."
    chroot_precise64
  elif (( ${_opt[--minicom]} )); then
    local dev='/dev/ttyUSB0'
    bind_knock_tmux_keys
    echo "$subproj: connecting to ${dev}..."
    minicom -w -D $dev -b 115200
  fi
}

