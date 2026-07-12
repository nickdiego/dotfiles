#!/usr/bin/env bash
# toggle-pane.sh — toggle a named split pane in the current tmux window.
#
# Usage: toggle-pane.sh <name> <cmd> [size=40] [dir=h] [full=0]
#
#   name   unique identifier for this pane within the window
#   cmd    shell command to run when first creating the pane
#   size   percentage of window width (h) or height (v), default 40
#   dir    h = horizontal side pane | v = vertical bottom pane, default h
#   full   1 = full window height/width (split-window -f)
#          0 = split only from the current pane, default 0
#
# State is tracked per-window via tmux window option @toggle_pane_<name>,
# storing "<pane_id> <size> <dir> <full>" so the original geometry can be
# replayed on re-show.

set -e

NAME="${1:?Usage: toggle-pane.sh <name> <cmd> [size] [dir] [full]}"
CMD="${2:-}"
SIZE="${3:-40}"
DIR="${4:-h}"
FULL="${5:-0}"

OPT="@toggle_pane_${NAME}"

CURR_WIN=$(tmux display-message -p '#{window_id}')
CURR_PATH=$(tmux display-message -p '#{pane_current_path}')

# Read stored state: "<pane_id> <size> <dir> <full>"
STORED=$(tmux show-options -wqv "$OPT" 2>/dev/null || true)
PANE_ID=$(echo "$STORED" | awk '{print $1}')

if [ -n "$PANE_ID" ] && tmux list-panes -a -F '#{pane_id}' 2>/dev/null | grep -qx "$PANE_ID"; then
  PANE_WIN=$(tmux display-message -p -t "$PANE_ID" '#{window_id}' 2>/dev/null || true)

  if [ "$PANE_WIN" = "$CURR_WIN" ]; then
    # Visible → hide, but only if it's not the sole remaining pane
    if [ "$(tmux display-message -p '#{window_panes}')" -gt 1 ]; then
      tmux break-pane -d -s "$PANE_ID"
    fi
  else
    # Hidden → rejoin with original geometry
    S=$(echo "$STORED" | awk '{print $2}')
    D=$(echo "$STORED" | awk '{print $3}')
    F=$(echo "$STORED" | awk '{print $4}')

    FULL_FLAG=
    [ "$F" = "1" ] && FULL_FLAG="-f"

    # shellcheck disable=SC2086
    tmux join-pane -"$D" $FULL_FLAG -l "${S}%" -s "$PANE_ID" -t "$CURR_WIN"
    tmux select-pane -t "$PANE_ID"
  fi
else
  # No pane or stale ID — create a fresh one
  tmux set-option -wqu "$OPT" 2>/dev/null || true

  FULL_FLAG=
  [ "$FULL" = "1" ] && FULL_FLAG="-f"

  # shellcheck disable=SC2086
  tmux split-window -"$DIR" $FULL_FLAG -l "${SIZE}%" -c "$CURR_PATH"
  PANE_ID=$(tmux display-message -p '#{pane_id}')
  tmux set-option -wq "$OPT" "$PANE_ID $SIZE $DIR $FULL"
  [ -n "$CMD" ] && tmux send-keys "$CMD" Enter
fi
