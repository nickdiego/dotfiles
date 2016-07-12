#!/bin/bash

custom_tool_config() {
  local tool=$1
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export QT_ROOT=$tool
  export ANDROID_NATIVE_API_LEVEL=android-9
  export ANT_LOCATION=/usr/bin/ant
  export PATH="$tools_dir/qt-5/Tools/QtCreator/bin:$PATH"
}

custom_tool_config "$tools_dir/qt-5/5.7/android_armv7"
#custom_tool_config '/usr/local/Qt-5.7.0/'
#custom_tool_config '/usr/local/Qt-5.7.0-Android-dhg'
unset custom_tool_config

