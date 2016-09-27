#!/bin/bash

config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_ibmo="$proj"
  local src_ibmo="$proj_ibmo/src"
  src_ibmo_lib="$src_ibmo/libibmo"
  src_ibmo_tool="$src_ibmo/ibmotool"
  alias ibmo="cd $src_ibmo"
}

config 'ibmo'
unset config
