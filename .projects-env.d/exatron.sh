#!/bin/bash

# std project variables
projname='exatron'

setenv() {
  local subproj=$1
  targets=('nodejs')
  options=('--node' '--dbserver')
  dirs[src]="exatron-piloto"
  defaultdir=src
}

activate() {
  function start_mysql() {
    local title="mysql-server"
    echo "Starting mysql server..."
    set-window-title "$title"
    sudo systemctl start mariadb
  }
  function start_node() {
    local title="exatron-server"
    echo "Starting Exatron server..."
    set-window-title "$title"
    cd "${dirs[root]}/${dirs[src]}"
    npm run dev-start
  }

  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
  # ...

  if (( ${_opt[--node]} )); then
    echo "$subproj: starting node..."
    start_node
  fi
}

