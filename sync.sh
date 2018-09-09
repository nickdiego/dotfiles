#!/usr/bin/env bash
# vim: et sw=2 ft=sh
# Symlink-based Installer/syncer script to keep
# dotfiles easily editable and up-to-date.

set -e

BOOTSTRAP=0
VERBOSE=0
BKPDIR="$HOME/.dot-backups/bkp-`date +'%b-%d-%y_%H:%M:%S'`"
PYTHON_PKGS=( i3ipc )

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
  nvim -u vim/plugins.vim +PlugInstall +qall
}

# Install submodules
if (( BOOTSTRAP )); then
  msg "Fetching submodules..."
  git submodule update --init
  msg "Installing tmux plugins..."
  tmux/plugins/tpm/scripts/install_plugins.sh
  if type pip &>/dev/null; then
    msg "Installing python packages..."
    pip install --user "${PYTHON_PKGS[@]}"
  else
    echo "WARN: Python packages not installed (pip not found)!" >&2
  fi
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

setfacl -m u:sddm:r face.icon ~/.face.icon

# Install vim plugins (using Vundle for now)
install_vim_plugins

# TODO: Check how to install pacman hooks without root access

# Reload shell
echo "Done." >&2
exec $SHELL -l
