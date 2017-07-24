#!/bin/bash

projname=dotfiles
subprojects=('proj-commander' 'awesome-config')

setenv() {
  dirs[src]='/'
  options=('--sync') # TODO impl support
  case $subproj in
    proj-commander)
      dirs[src]=".proj-commander"
      ;;
    awesome-config)
      dirs[src]=".xdg-config/awesome-config"
      ;;
  esac
}

activate() {
  # FIXME Temp: Will be moved to 'install'
  # function latter.
  if (( ${_opt[--sync]} )); then
    echo "Let's sync the dotfiles :)"
    cd_project $projname
    ./sync.sh
  fi
}

