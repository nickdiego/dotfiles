#!/bin/bash

projname=qt5

setenv() {
  dirs[src]=src/qt5
  targets=('Msys-x86_64' 'Linux-x86_64')
}

activate() {
  dirs[build]="build/$target" #TODO
  target=${targets[0]} # FIXME get from parameters

  # TODO Call come env initialization script
}

