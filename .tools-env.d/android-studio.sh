#!/bin/bash

custom_tool_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export ANDROID_STUDIO_HOME=$tool
  export PATH="$PATH:$ANDROID_STUDIO_HOME/bin"

}

custom_tool_config 'android-studio'
unset custom_tool_config

