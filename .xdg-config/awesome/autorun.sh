#!/usr/bin/env bash

function run() {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start apps
run nm-applet
run dropbox
run chromium --no-startup-window
