# Multihead helper functions
# To see current display config, execute:
# $ xrandr -q

# TODO automate this using xrandr+awk
# Running Wayland
if [ ! -z $WAYLAND_DISPLAY ]; then
  export DISPLAY_MAIN='XWAYLAND0'
  export DISPLAY_AUX='XWAYLAND1'
else # assuming Running Xorg
  case `hostname` in
    mayam)
        export DISPLAY_MAIN='eDP1'
        export DISPLAY_AUX='DP1'
        ;;
    *)
        export DISPLAY_MAIN='LVDS1'
        export DISPLAY_AUX='HDMI1'
        ;;
  esac
fi

# Add new xrandr display mode
add-display-mode() {
  local hres=${1:-1440} vres=${2:-900}
  local name=${3:-"${hres}x${vres}_custom"}
  local mode=$(cvt $hres $vres | tail -n1 | sed 's,^Modeline ".\+"\s\+,,')
  xrandr --newmode "$name" $mode 2>/dev/null || return 1
}

_arrange_displays_opts=( --disable --enable )

