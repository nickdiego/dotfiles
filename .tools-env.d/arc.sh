#!/bin/bash

custom_tool_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export tool_phabricator=$tool/phabricator
  export tool_arc=$tool/arcanist
  export PATH="$PATH:$tool_arc/bin"
  if [ -f $tool_arc/resources/shell/bash-completion ]; then
    . $tool_arc/resources/shell/bash-completion
  fi
}

custom_tool_config 'Phabricator'
unset custom_tool_config

