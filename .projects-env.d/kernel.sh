#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_kernel=$proj
  src_kernel="$proj_kernel/src/linux-2.6"
  alias kcd="cd $kernel_src_path"
}

custom_proj_config 'kernel'
unset custom_proj_config

