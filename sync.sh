#!/usr/bin/env bash
#
# Symlink-based Installer/syncer script to keep
# dotfiles easily editable and up-to-date.

set -e

BOOTSTRAP=0
VERBOSE=0
BKPDIR="$HOME/.dot-backups/bkp-`date +'%b-%d-%y_%H:%M:%S'`"

while (( $# )); do
  case $1 in
    --bootstrap | -b)
      BOOTSTRAP=1
      ;;
    --verbose | -v)
      VERBOSE=1
      ;;
    *)
      echo "Error: Unrecognized option!"
      exit 1
      ;;
  esac
  shift
done

msg() {
  if (( VERBOSE )); then
    printf "%s\n" "$*" >&2
  fi
}

backup_dot() {
  local src=$1
  local dstdir="${BKPDIR}/${src##$HOME/}"
  mkdir -p $dstdir
  mv $src $dstdir
  echo "${dstdir}/$(basename $src)"
}

sync_dot_file() {
  local file=$1
  local link=${2:-$file}
  local src="${PWD}/${file}"
  local tgt="${HOME}/${link}"

  if [[ -L "$tgt" && "$(readlink -f $tgt)" == "$(readlink -f $src)" ]]; then
    #msg "Skipping ${file} -> ${link} [already installed]"
    return 0
  fi

  if [[ -f "$tgt" || -d "$tgt" ]]; then
    msg "Replacing ${file} -> ${link} [bkp: $(backup_dot $tgt)]"
  else
    msg "Linking ${file} -> ${link}"
  fi

  ln -sf $src $tgt
}

sync_dot_files() {
  local ignoredirs='-I ".*~" -I .git -I .gitmodules -I sync.sh -I .kde -I .xdg-config -I .local-config'
  local files_to_install=`eval "ls --color=never -A $ignoredirs"`

  for file in $files_to_install; do
    sync_dot_file $file
  done
}

install_vim_plugins() {
  # install the Vundle plugins configured in .vimrc
  nvim -u .vim/plugins.vim +PlugInstall +qall
}

# Install submodules
if (( BOOTSTRAP )); then
  msg "Fetching submodules..."
  git submodule update --init
  # Install tmux plugins
  msg "Installing tmux plugins..."
  .tmux/plugins/tpm/scripts/install_plugins.sh
  msg "Installing powerline..."
  .powerline/fonts/install.sh
fi

# Sync plain/simple dot files/dirs
sync_dot_files

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
sync_dot_file .xdg-config/base16-shell .config/base16-shell
sync_dot_file .xdg-config/powerline .config/powerline
sync_dot_file .xdg-config/sddm-breeze.conf .config/sddm-breeze.conf
sync_dot_file .xdg-config/fontconfig .config/fontconfig
sync_dot_file .xdg-config/htop .config/htop
sync_dot_file .xdg-config/i3 .config/i3

sync_dot_file .pixmaps/face.icon .face.icon
setfacl -m u:sddm:r .pixmaps/face.icon
setfacl -m u:sddm:r $HOME/.face.icon

# Install vim plugins (using Vundle for now)
install_vim_plugins

# TODO: Check how to install pacman hooks without root access

# Reload shell
echo "Done." >&2
exec $SHELL -l
