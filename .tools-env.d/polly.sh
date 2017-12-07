#!/bin/bash

POLLY_DIR=${POLLY_DIR_DEFAULT:=$tools_dir/polly}
POLLY_DOWNLOAD_URL="git@github.com:forexample/android-cmake.git"

_polly_config() {
  test -d $POLLY_DIR || return 1
  (( $verbose_env )) && echo Setting env for $POLLY_DIR

  polly_build() {
    local bindir="${POLLY_DIR}/bin"
    PATH="$PATH:$bindir" ${bindir}/build.py "$@"
  }

  # TODO improve this
  if is_bash; then
      local opts=( --toolchain --verbose --config --target)
      complete -W "${opts[*]}" polly_build
  fi
}

_polly_download() {
  echo "## Downloading polly..."
  pushd "$POLLY_DIR/.."
  git clone $POLLY_DOWNLOAD_URL
  popd
}

_polly_config
