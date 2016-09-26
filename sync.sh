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
    return 1
  fi
  if [[ -f $tgt || -d $tgt ]]; then
    echo "replacing..."
    backup_dot_file $tgt
  else
    echo "linking..."
  fi
  ln -sf $src $tgt
}

sync_dot_files() {
  local ignoredirs='-I ".*~" -I .git -I .gitmodules -I sync.sh -I .kde -I .xdg-config'
  local files_to_install=`eval "ls --color=never -A $ignoredirs"`

  for file in $files_to_install; do
    sync_dot_file $file
  done
}

install_vim_plugins() {
  # downloads Vundle plugin manager
  [ -d .vim/bundle ] || mkdir -p .vim/bundle
  [ -d .vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the Vundle plugins configured in .vimrc
  vim -u .vim/plugins.vim +PluginInstall +qall
}

bkpdir="$HOME/.dot-backups/bkp-`date +'%b-%d-%y_%H:%M:%S'`"

# Sync plain/simple dot files/dirs
sync_dot_files

# Sync xdg-config files
# FIXME generalize this to work with all dirs inside .xdg-config
sync_dot_file .xdg-config/awesome .config/awesome

# Install vim plugins (using Vundle for now)
install_vim_plugins

# Reload bashrc
. ~/.bashrc

unset bkpdir

# TODO instruct to install by the simple way (./install.py --...)
echo ==========================================================
echo To YouCompleteMe ViM plugin to work you\'ll need some
echo manual work :\(
echo -\> Download the latest stable binaries for
echo clang at http://llvm.org and extrat it at ~/bin/clang-binaries for example
echo and then follow the instructions at:
echo https://github.com/Valloric/YouCompleteMe/#full-installation-guide
echo step 4. Compile the ycm_support_libs libraries
echo passing the flag -DPATH_TO_LLVM_ROOT=~/bin/clang-binaries
echo ...
echo ==========================================================
