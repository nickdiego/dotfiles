#!/bin/bash

_qt_rootdir=${QT_ROOTDIR_DEFAULT:=$tools_dir/qt-5}
_qt_version=${QT_VERSION_DEFAULT:=5.8}
_qt_target_plat=${QT_TARGETPLAT_DEFAULT:='android_armv7'}

## options related stuff
_qt_config_opts=(
  --version
  --target
)
_parse_qt_options() {
  local var_version=$1 && shift || return 1
  local var_target=$1 && shift || return 1
  local version_decl target_decl
  while (( $# )); do
    case $1 in
      --version) shift && [[ $1 ]] && version_decl="local ${var_version}=$1";;
      --target) shift && [[ $1 ]] && target_decl="local ${var_target}=$1";;
    esac
    shift
  done
  [[ $version_decl ]] || version_decl="local ${var_version}=${_qt_version}"
  [[ $target_decl ]] || target_decl="local ${var_target}=${_qt_target_plat}"
  echo "${version_decl}; ${target_decl};"
}

## qt config function
qt_config() {
  eval $(_parse_qt_options _qt_version _qt_target_plat $@)

  local qt_toolsdir="${_qt_rootdir}/Tools"
  if [[ -d ${qt_toolsdir}/QtCreator ]]; then
    export PATH="${qt_toolsdir}/QtCreator/bin:$PATH"
  else
    (( $verbose_env )) && echo "QtCreator not found!"
  fi

  local qt_versiondir="${_qt_rootdir}/${_qt_version}"
  test -d $qt_versiondir || return 1

  (( $verbose_env )) && echo Setting env for $_qt_rootdir
  export QTDIR=$qt_versiondir
  # TODO set QMAKESPEC ?

  local qt_targetplatdir="${qt_versiondir}/${_qt_target_plat}"
  test -d $qt_targetplatdir || {
    echo "Failed config Qt: invalid target platform dir $qt_targetplatdir"
    unset -v QT_PLATFORM_DIR
    return 1
  }

  export QT_PLATFORM_DIR="${qt_versiondir}/${_qt_target_plat}"
  export PATH="${QT_PLATFORM_DIR}/bin:$PATH"

  if [[ $_qt_target_plat == android_armv7 ]]; then
    export ANDROID_NATIVE_API_LEVEL=android-9
    export ANT=/usr/bin/ant
  fi
}

### Bash completion stuff
_qt_config_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev="${COMP_WORDS[$(($COMP_CWORD - 1))]}"
  local args=( "${COMP_WORDS[@]}" )

  eval $(_parse_qt_options version target ${args[@]})
  local versions=( $(basename -a ${_qt_rootdir}/5.*) )
  local versiondir="${_qt_rootdir}/${version}"
  local platforms=( $(basename -a ${versiondir}/*) )
  declare -a result
  if [[ $prev != --* ]]; then
    result=( ${_qt_config_opts[@]} )
  else
    case $prev in
      --version) result=( ${versions[@]} );;
      --target) result=( ${platforms[@]} );;
    esac
  fi
  COMPREPLY=( $(compgen -W "${result[*]}" -- ${cur}) )
} && complete -F _qt_config_completion qt_config


##########################################
# Let's initialize with default values
##########################################
#qt_config

