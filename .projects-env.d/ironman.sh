#!/bin/bash

custom_proj_config() {
  local proj=$proj_dir/$1
  test -d $proj || return 1
  [ ! -z $verbose_env ] && echo Setting env for $proj

  proj_iron=$proj
  local src_iron_root="$proj_dir/iron-man/src/certi_hardware_diagnosis"
  src_iron_srv="$src_iron_root/dev/apps/diagnosis-server"
  src_iron_clt="$src_iron_root/dev/apps/diagnosis-control-center"

  alias set_certi_product="$src_iron_root/externals/certi_common_libs/scripts/setproduct.sh certi_desktop_linux"
  alias iron="cd $src_iron_root"
  alias ironsrv="cd $src_iron_srv"
  alias ironclt="cd $src_iron_clt"
  alias ironclt_build="cd $src_iron_root/.build_certi_desktop_linux_x86_64/dev/apps/diagnosis-control-center/src"
  alias ironclt_tests="cd $src_iron_root/.build_certi_desktop_linux_x86_64/dev/tests/diagnosis-control-center/src"
}

custom_proj_config 'iron-man'
unset custom_proj_config
