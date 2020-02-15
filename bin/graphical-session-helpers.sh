# vim: tw=80 ts=2 sw=2 et filetype=sh

# xsession
_xsession_opts=(i3 gnome kde xfce)
function xsession() {
  #env QT_QPA_PLATFORM=x11 \
    #GDK_BACKEND=x11 \
    #XDG_SESSION_TYPE=x11 \
  startx ~/.xinitrc $@
}

# wlsession
_wlsession_opts=(gnome sway weston)
function wlsession() {
  local s=${1:-gnome}
  [ $s = 'gnome' ] && s+='-session'
  env QT_QPA_PLATFORM=wayland \
    GDK_BACKEND=wayland \
    XDG_SESSION_TYPE=wayland \
      dbus-run-session $s
}

# bash/zsh completion
if type complete &>/dev/null; then
    complete -W "${_xsession_opts[*]}" xsession
    complete -W "${_wlsession_opts[*]}" wlsession
elif type compctl &>/dev/null; then
    compctl -k "(${_xsession_opts[*]})" xsession
    compctl -k "(${_wlsession_opts[*]})" wlsession
fi

