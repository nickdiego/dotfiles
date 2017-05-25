#!/bin/bash

_integrity_config() {
  local tool=$tools_dir/$1
  test -d $tool || return 1
  (( $verbose_env )) && echo Setting env for $tool

  export PATH="${tool}/bin:$PATH"
}

_integrity_config 'IntegrityClient10'

