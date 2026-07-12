#!/usr/bin/env bash
# TPM entry point: sets @toggle-pane-path so tmux.conf bindings can reference
# the scripts directory without hardcoding the install path.
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
tmux set-option -gq "@toggle-pane-path" "$PLUGIN_DIR/scripts"
