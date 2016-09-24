#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_knockout=$proj
  local src_knockout_root="$proj_knockout/repos"
  alias knock="cd $src_knockout_root"
}

custom_proj_config 'knockout'
unset custom_proj_config

knock-chroot() {
  schroot -c precise64 &&
  set-window-title "CHROOT (Ubuntu 12.04 x86_64)"
}
