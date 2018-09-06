#!/bin/bash

# TODO make it more configurable (like qt_config, for example)
export USE_SCHEDULER=10.60.69.53
icecc_config() {
  #export ICECC_VERSION=$HOME/.icecc/linux-x86_64-gcc4.6.3-x86_64.tar.gz
  #export ICECC_VERSION=$HOME/.icecc/linux-x86_64-gcc4.8.1-x86_64.tar.gz
  export ICECC_VERSION=$HOME/.icecc/linux-x86_64-gcc4.7.3-x86_64.tar.gz
  export CCACHE_PREFIX=icecc
  for i in gcc g++ cc c++; do
    ln -sf /usr/bin/ccache $HOME/bin/$i
  done
}

#Don't enable it by default
#icecc_config

