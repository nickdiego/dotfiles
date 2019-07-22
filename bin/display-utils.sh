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
        export DISPLAY_AUX=('DP1' 'DP2')
        export DISPLAY_CMD_ENABLE_AUX="\
          --output eDP1 --off \
          --output DP1 --auto --primary \
          --output DP2 --auto --left-of DP1"
        ;;
  esac
fi

# Add new xrandr display mode
display_add_mode() {
  local hres=${1:-1440} vres=${2:-900}
  local name=${3:-"${hres}x${vres}_custom"}
  local mode=$(cvt $hres $vres | tail -n1 | sed 's,^Modeline ".\+"\s\+,,')
  xrandr --newmode "$name" $mode 2>/dev/null || return 1
}

display_disable_aux() {
  declare -a args
  for display in "${DISPLAY_AUX[@]}"; do
    args+=( --output $display --off )
  done
  xrandr "${args[@]}" --output $DISPLAY_MAIN --auto
}

display_enable_aux() {
  if [ -z "$DISPLAY_CMD_ENABLE_AUX" ]; then
    # TODO: Generate default cmd
    echo "Display config not set for this machine." >&2
    return 1
  fi

  xrandr $DISPLAY_CMD_ENABLE_AUX
}
