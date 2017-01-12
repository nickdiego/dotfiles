#!/bin/bash

qt_config() {
  local qt_rootdir=${QT_ROOTDIR_DEFAULT:=$tools_dir/qt-5}
  local version=${QT_VERSION_DEFAULT:=5.7}
  local target_plat=${QT_TARGETPLAT_DEFAULT:='android_armv7'}
  while (( $# )); do
    case $1 in
      --version)
        shift && version=$1;;
      --target)
        shift && target_plat=$1;;
      # TODO impl root dir
    esac
    shift
  done

  local qt_toolsdir="${qt_rootdir}/Tools"
  if [[ -d ${qt_toolsdir}/QtCreator ]]; then
    export PATH="${qt_toolsdir}/QtCreator/bin:$PATH"
  else
    (( $verbose_env )) && echo "QtCreator not found!"
  fi

  local qt_versiondir="${qt_rootdir}/${version}"
  test -d $qt_versiondir || return 1

  (( $verbose_env )) && echo Setting env for $qt_rootdir
  export QTDIR=$qt_versiondir
  # TODO set QMAKESPEC ?

  local qt_targetplatdir="${qt_versiondir}/${target_plat}"
  test -d $qt_targetplatdir || {
    echo "Failed config Qt: invalid target platform dir $qt_targetplatdir"
    unset -v QT_PLATFORM_DIR
    return 1
  }

  export QT_PLATFORM_DIR="${qt_versiondir}/${target_plat}"
  export PATH="${QT_PLATFORM_DIR}/bin:$PATH"
  export QT_PLATFORMS=( $(basename -a ${qt_versiondir}/*) )

  # Used by cmake-based projects meant to run in android
  export Qt5_host="${qt_versiondir}/gcc_64"
  export Qt5_android="${qt_versiondir}/android_armv7"

  if [[ ${QT_PLATFORMS[@]} =~ android_armv7 ]]; then
    export ANDROID_NATIVE_API_LEVEL=android-9
    export ANT=/usr/bin/ant
  fi
}

qt_config

# TODO implement bash completion support
