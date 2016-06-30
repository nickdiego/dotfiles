#!/bin/bash

custom_tool_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export ANDROID_SDK_HOME=$tool
  export PATH="$PATH:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform_tools"

}

custom_tool_config 'android-sdk'
unset custom_tool_config

