#!/bin/bash

build_qt_default='x86_64'

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_qt="$proj_dir/qt"
}

switch_qt() {
  local build_dir=$proj_qt/build/$1
  if [ ! -d $build_dir ] || [ ! -d $build_dir/qtbase ]; then
    echo \#\# Failed to switch to qt build \"$1\"
    echo \#\# Choose a valid Qt build dir!!
    return 1
  fi

  remove_from_path $proj_qt/build/*/qtbase/bin
  build_qt="$build_dir/qtbase"
  export QTDIR=$build_qt
  export PATH="$build_qt/bin:$PATH"
}

custom_proj_config 'qt'
unset custom_proj_config

_qt_builds() {
  local cur prev builds

  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  builds=$([ -d $proj_qt/build ] && basename -a `ls --color=no $proj_qt/build`)

  COMPREPLY=( $(compgen -W "${builds}" -- ${cur}) )
  return 0
}

complete -F _qt_builds switch_qt
#switch_qt $build_qt_default

config_qt_for_android() {
  local src_dir=$proj_qt/src/qt5
  cd $src_dir &&
  ./configure -xplatform android-g++ -nomake tests -nomake examples \
    -android-ndk $ANDROID_NDK -android-sdk $ANDROID_SDK \
    -android-ndk-host linux-x86_64 -android-toolchain-version 4.9 \
    -skip qttranslations -skip qtwebkit -skip qtserialport \
    -skip qtwebkit-examples -no-warnings-are-errors \
    -opensource -confirm-license
}

build_qt_for_android() {
  local src_dir=$proj_qt/src/qt5
  cd $src_dir && make -j4
}


