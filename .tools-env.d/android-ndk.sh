#!/bin/bash

version='r12'

custom_tool_config() {
  local tool=$tools_dir/${1}-${version}
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export ANDROID_NDK_HOME=$tool
  export PATH="$PATH:$ANDROID_NDK_HOME"
}

custom_tool_config 'android-ndk'
unset custom_tool_config
unset version
