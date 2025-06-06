#!/usr/bin/env bash
# vim: et sw=2 ft=sh
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

install_vim_plugins() {
  # install the Vundle plugins configured in .vimrc
  msg "Installing vim plugins..."
  command vim -u vim/plugins.vim +PlugInstall +qall
  command nvim -u vim/lua/config/lazy.lua '+Lazy sync' +qall
}

install_tmux_plugins() {
  msg "Installing tmux plugins..."
  tmux/plugins/tpm/scripts/install_plugins.sh
}

# Install submodules
if (( BOOTSTRAP )); then
  msg "Fetching submodules..."
  git submodule update --init --recursive
fi

# Sync plain/simple dot files/dirs
for d in * config/*; do
  case "$d" in
    config/*)
      sync_dot_file "$d" ".config/${d##config/}"
      ;;
    config)
      continue
      ;;
    *)
      sync_dot_file "$d" ".${d}"
      ;;
  esac
done

# Install vim plugins (using Plug for now)
install_vim_plugins

install_tmux_plugins

# TODO: Check how to install pacman hooks without root access

# Reload shell
echo "Done." >&2
exec $SHELL -l
