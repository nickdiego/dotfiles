#!/bin/bash

custom_tool_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export JAVA_HOME=$tool
  export PATH="$PATH:$JAVA_HOME/bin"
}

custom_tool_config 'jdk1.8.0_92'
unset custom_tool_config

