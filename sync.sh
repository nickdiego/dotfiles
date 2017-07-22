#!/bin/bash

backup_dot_file() {
  local f=$1
  local dir=$(dirname "$bkpdir/`echo $f | sed "s,$HOME/,,"`")
  [ -d $dir ] || mkdir -p $dir
  mv $f $dir
}

sync_dot_file() {
  local file=$1
  local link=$2
  [ -z $link ] && link=$file
  local src=$PWD/$file
  local tgt=$HOME/$link

  echo -n "Installing ${src}: "
  if [[ -L $tgt && `readlink -f $tgt` = $src ]]; then
    echo "skipping..."
    return 0
  fi
  if [[ -f $tgt || -d $tgt ]]; then
    echo "replacing..."
    backup_dot_file $tgt || return 1
  else
    echo "linking..."
  fi
  ln -sf $src $tgt
  return 0
}

sync_dot_files() {
  local ignoredirs='-I ".*~" -I .git -I .gitmodules -I sync.sh -I .kde -I .xdg-config -I .local-config'
  local files_to_install=`eval "ls --color=never -A $ignoredirs"`

  for file in $files_to_install; do
    sync_dot_file $file || return 1
  done
  return 0
}

install_vim_plugins() {
  # downloads Vundle plugin manager
  [ -d .vim/bundle ] || mkdir -p .vim/bundle
  [ -d .vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the Vundle plugins configured in .vimrc
  vim -u .vim/plugins.vim +PluginInstall +qall

  if [ $? -ne 0 ]; then
    echo "### Error: Failed to install Vim plugins!"
    return 1
  fi

  local ycm_path=.vim/bundle/YouCompleteMe
  local ycm_core_lib=${ycm_path}/third_party/ycmd/ycm_core.so
  if [ -f $ycm_core_lib ]; then
    echo "YouCompleteMe: ycm_core.so already exists. Skipping..."
    return 0
  fi

  echo ==========================================================
  echo Trying to compile native YouCompleteMe support libs...
  echo NOTE: If it fails you\'ll must check the logs and install
  echo it manually \;\)
  echo ==========================================================
  local log=ycm_compile.log
  pushd $ycm_path

  ./install.py --clang-completer > $log
  local result=$?
  if [ $result -eq 0 ]; then
    echo "YouCompleteMe build succeeded!"
    rm ${log}
  else
    echo "YouCompleteMe build failed!"
    echo "Check ${log} for more details."
  fi
  popd
  return $result
}

install_submodules() {
  echo "Fetching submodules..."
  git submodule update --init &&
  git submodule foreach git checkout master &&
  echo "Installing tmux plugins..."
  .tmux/plugins/tpm/scripts/install_plugins.sh &&
  echo "Installing powerline..."
  .powerline/fonts/install.sh
}

bkpdir="$HOME/.dot-backups/bkp-`date +'%b-%d-%y_%H:%M:%S'`"


# Install submodules
install_submodules &&

# Sync plain/simple dot files/dirs
sync_dot_files &&

# Sync xdg-config files
# FIXME generalize this to work with all dirs inside .xdg-config
sync_dot_file .xdg-config/awesome-config .config/awesome
sync_dot_file .xdg-config/konsolerc .config/konsolerc
sync_dot_file .xdg-config/mimeapps.list .config/mimeapps.list
sync_dot_file .xdg-config/nvim .config/nvim
sync_dot_file .xdg-config/termite .config/termite
sync_dot_file .xdg-config/ranger .config/ranger
sync_dot_file .xdg-config/gtk-3.0 .config/gtk-3.0
sync_dot_file .xdg-config/kscreenlockerrc .config/kscreenlockerrc

sync_dot_file .pixmaps/face.icon .face.icon
setfacl -m u:sddm:r .pixmaps/face.icon
setfacl -m u:sddm:r $HOME/.face.icon

# Install vim plugins (using Vundle for now)
install_vim_plugins

# Reload bashrc
. ~/.bashrc &&

echo "DONE!"
unset bkpdir
