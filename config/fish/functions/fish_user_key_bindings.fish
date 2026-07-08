function fish_user_key_bindings
    # Alt/Option-Left/Right: move by word.
    # \e[1;3x = standard Alt modifier; \e[1;9x = iTerm2's "Option sends Esc+"
    # variant. Ghostty sends the standard codes when macos-option-as-alt is
    # set, but both are bound for safety across terminals.
    bind \e\[1\;3D backward-word
    bind \e\[1\;3C forward-word
    bind \e\[1\;9D backward-word
    bind \e\[1\;9C forward-word

    bind \er 'exec fish -l'
    bind \et 'tig; commandline -f repaint'
    bind \e\r _prepend_sudo
    bind \cH _insert_last_cmd_output
end

function _prepend_sudo
    commandline -C 0
    commandline -i 'sudo '
end

function _insert_last_cmd_output
    commandline -i (eval $history[1])
end
