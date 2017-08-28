#!/bin/bash

_python_config_opts=(
--version
)
## python config function
python_config() {
  local dir="$HOME/.bin"
  while (( $# )); do
    case $1 in
      --version)
        shift
        if [[ -z "$1" || "$1" = default ]]; then
          rm -fv ${dir}/python ${dir}/python-config
        else
          ln -sfv $(type -p "python${1}") ${dir}/python
          ln -sfv $(type -p "python${1}-config") ${dir}/python-config
        fi
        ;;
    esac
    shift
  done
}

_python_available_versions() {
  local cmds=( `compgen -c python` )
  local result=( default )
  for c in ${cmds[@]}; do
    if [[ $c =~ python[0-9].[0-9]+$ ]]; then
      result+=( ${c#python} )
    fi
  done
  echo ${result[@]}
}

### Bash completion stuff
_python_config_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev="${COMP_WORDS[$(($COMP_CWORD - 1))]}"
  local args=( "${COMP_WORDS[@]}" )

  declare -a result versions
  versions=( $(_python_available_versions) )
  if [[ $prev != --* ]]; then
    result=( ${_python_config_opts[@]} )
  else
    if [ $prev = --version ]; then
      result=( ${versions[@]} )
    fi
  fi
  COMPREPLY=( $(compgen -W "${result[*]}" -- ${cur}) )
} && complete -F _python_config_completion python_config


##########################################
# Let's initialize with default values
##########################################
#python_config --version 2.7 >/dev/null

