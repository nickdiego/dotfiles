#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_qt="$proj_dir/qt"
  build_qt="$proj_qt/build/x86_64/qtbase"
  export PATH="$build_qt/bin:$PATH"
  export QTDIR=$build_qt
}

custom_proj_config 'qt'
unset custom_proj_config

