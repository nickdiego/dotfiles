#!/bin/bash

sudo apt-get install vim-gtk clang exuberant-ctags git python-fontforge unzip \
  python-dev silversearcher-ag

git submodule update --init
git submodule foreach git checkout master

pushd .vim/unbundle/general/vim-powerline
git checkout develop
popd

BKPDIR="$HOME/.dot-backups"
[ -d $BKPDIR ] || mkdir -p $BKPDIR

link_dot_files() {
  for file in `ls -A -I .git -I .gitmodules -I setup.sh -I .kde -I .config`;
  do
    echo $PWD/$file

    if [ $PWD/$file == `readlink -f $HOME/$file` ]; then
      echo "skipping..."
      continue
    elif [ -e $HOME/$file ]; then
      echo "backing up..."
      mv $HOME/$file $BKPDIR/$file-backup-`date +%Y%m%d%H%M%S`
      echo "replacing..."
    else
      echo "linking..."
    fi

    ln -sf $PWD/$file $HOME
  done
}

install_vim_plugins() {
  # downloads Vundle plugin manager
  [ -d .vim/bundle ] || mkdir -p .vim/bundle
  [ -d .vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the Vundle plugins configured in .vimrc
  vim +PluginInstall +qall

  ls $HOME/.fonts/Ubuntu*-Powerline.ttf > /dev/null
}

link_dot_files
install_vim_plugins

if [ $? -ne 0  ]; then
	mkdir -p ~/tmp
	wget -c http://font.ubuntu.com/download/ubuntu-font-family-0.80.zip -O ~/tmp/ubuntu-font-family-0.80.zip
	unzip ~/tmp/ubuntu-font-family-0.80.zip -d ~/tmp

	pushd ~/tmp/ubuntu-font-family-0.80
	chmod +x ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher
	for f in `ls *.ttf`;
	do
		~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher $f
	done
	fonts=`ls *Powerline.ttf`
	if [ $? -eq 0 ]; then
		mkdir -p $HOME/.fonts
		cp $fonts $HOME/.fonts
		sudo fc-cache -vf
	fi
	popd
#	rm -rf ~/tmp
fi

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

