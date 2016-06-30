#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_ibmo="$proj"
  local src_ibmo="$proj_ibmo/src"
  src_ibmo_lib="$src_ibmo/src/libibmo"
  src_ibmo_tool="$src_ibmo/src/ibmotool"
  alias ibmo="cd $src_ibmo"
}

custom_proj_config 'ibmo'
unset custom_proj_config
