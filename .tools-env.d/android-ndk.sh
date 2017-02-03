#!/bin/bash

version='r12'

custom_tool_config() {
  local tool=$tools_dir/${1}-${version}
  test -d $tool || return 1
  [ ! -z $verbose_env ] && echo Setting env for $tool

  export ANDROID_NDK=$tool
  export ANDROID_NDK_TOOLCHAIN_ROOT="${ANDROID_NDK}/toolchains"
  export ANDROID_NDK_r12b=$tool
  export ANDROID_NDK_TOOLCHAIN_ARM="${ANDROID_NDK_TOOLCHAIN_ROOT}/arm-linux-androideabi-4.9/prebuilt/linux-x86_64"
  export PATH="$PATH:${ANDROID_NDK_TOOLCHAIN_ARM}/bin"
}

custom_tool_config 'android-ndk'
unset custom_tool_config
unset version
