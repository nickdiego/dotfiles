# Restore blinking beam cursor after any program that changes cursor shape
# (e.g. neovim switches to block; this fires when control returns to the shell).
function _restore_cursor --on-event fish_postexec
    printf '\e[0 q'
end
