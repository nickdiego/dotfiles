# vim: ts=4 sw=4 et filetype=sh

# Base16 theme stuff
_B16_FAVS=( solarflare snazzy oceanext atelier-lakeside onedark \
            materia monokai darktooth tomorrow-night seti default-dark )
if is_bash; then
  _B16_SHELL_PATH="$HOME/.config/base16-shell"
  _B16_THEME_NAME='default-dark'
  _B16_THEME_SCRIPT="${_B16_SHELL_PATH}/scripts/base16-${_B16_THEME_NAME}.sh"
  if [ -s $_B16_SHELL_PATH/profile_helper.sh ]; then
    source $_B16_SHELL_PATH/profile_helper.sh
    test -e "$HOME/.vimrc_background" || \
      _base16 ${_B16_THEME_SCRIPT} ${_B16_THEME_NAME}
  fi
fi

