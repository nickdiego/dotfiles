#!/bin/bash

projname=dotfiles

setenv() {
  dirs[src]=${projroot}
  options=('--sync') # TODO impl support
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

