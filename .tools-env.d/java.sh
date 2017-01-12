#!/bin/bash

_java_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  (( $verbose_env )) && echo Setting env for $tool

  export JAVA_HOME=$tool
  export PATH="$JAVA_HOME/bin:$PATH"
}

_java_config 'jdk1.8.0_92'

