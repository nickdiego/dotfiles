#!/bin/bash

if [ `uname` != 'Linux' ]; then
  echo '######## Trying to install script in a non-Linux environment!'
  echo '######## This is still untested and most probably wont work :('
else
  sudo pacman -S tmux openssh git nfs-utils highlight \
    the_silver_searcher acpi \
    faience-icon-theme gtk-engine-murrine \ # visual stuff
    graphicsmagick bash-completion autojump xclip
fi

# download and install manually https://github.com/mclmzz/arc-theme-Red

git submodule update --init
git submodule foreach git checkout master

pushd .vim/unbundle/general/vim-powerline
git checkout develop
popd

BKPDIR="$HOME/.dot-backups"
[ -d $BKPDIR ] || mkdir -p $BKPDIR

link_dot_file() {
  local file=$1
  local link=$2
  test -z $link && link=$file

  if [ $PWD/$file == `readlink -f $HOME/$link` ]; then
    echo "skipping..."
    return 1
  elif [ -e $HOME/$file ]; then
    echo "replacing..."
    mv $HOME/$file $BKPDIR/$file-backup-`date +%Y%m%d%H%M%S`
  else
    echo "linking..."
  fi
  ln -sfv $PWD/$file $HOME
}

link_dot_files() {
  local ignoredirs="-I '.*~' -I .git -I .gitmodules -I setup.sh -I .kde -I .xdg-config"
  for file in `ls -A $ignoredirs`;
  do
    echo -n "Installing $PWD/$file: "
    link_dot_file $file
  done
}

install_vim_plugins() {
  # downloads Vundle plugin manager
  [ -d .vim/bundle ] || mkdir -p .vim/bundle
  [ -d .vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the Vundle plugins configured in .vimrc
  vim +PluginInstall +qall
}

link_dot_files
install_vim_plugins
bashrc-reload

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

