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

function wl_record_screen() {
  type swaymsg &>/dev/null || { echo "swaymsg not installed!"; return 1; }
  type wf-recorder &>/dev/null || { echo "wf-recorder not installed!"; return 1; }
  test -n "$WAYLAND_DISPLAY" || { echo "WAYLAND_DISPLAY not set!"; return 1; }
  type ffplay &>/dev/null || { echo "ffplay not installed!"; return 1; }

  local -a opts
  local outfile='screencast.mp4'
  local reclog='/tmp/scrrec.log'
  local play=0

  while (( $# )); do
    case $1 in
      -p|--play)
        play=1
        ;;
      -*|--*)
        opts+=("$1")
        ;;
      *)
        outfile=$1
        ;;
    esac
    shift
  done

  local jq_query='.[] | select(.active) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'
  if false; then # TODO: Support selecting a screen area?
    local rect=$(swaymsg -t get_outputs | jq -r "$jq_query" | slurp)
    opts+=(-g "$rect")
    echo "Capturing rect ${rect}..."
  fi

  echo "Recording... outfile=${outfile}"
  wf-recorder "${opts[@]}" -f "$outfile" 2>$reclog
  if [ $? -ne 0 ]; then
    echo "Failed to record screen!!";
    cat -n $reclog
    return 1;
  fi

  (( play )) && echo "Playing..." && ffplay $outfile
}

# bash/zsh completion
if type complete &>/dev/null; then
    complete -W "${_xsession_opts[*]}" xsession
    complete -W "${_wlsession_opts[*]}" wlsession
elif type compctl &>/dev/null; then
    compctl -k "(${_xsession_opts[*]})" xsession
    compctl -k "(${_wlsession_opts[*]})" wlsession
fi

