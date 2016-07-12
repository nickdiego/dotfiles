#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_drunk=$proj
  local src_drunk_root="$proj/src"
  src_drunk_srv="$src_drunk_root/server-prototype"
  src_drunk_clt="$src_drunk_root/qt-client-prototype"

  alias drunk="cd $src_drunk_root"
  alias drunksrv="cd $src_drunk_srv"
  alias drunkclt="cd $src_drunk_clt"
}

custom_proj_config 'drunk-waiter'
unset custom_proj_config
