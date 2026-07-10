# Only run for interactive shells: the theme script emits OSC color sequences to
# stdout, which would contaminate system() calls from editors like vim/nvim.
if status is-interactive; and test -e ~/.config/base16-shell/profile_helper.fish
    source ~/.config/base16-shell/profile_helper.fish
    if not test -e ~/.base16_theme
        base16-default-dark
    end
end

# profile_helper.fish has a bug: it uses $BASE16_THEME (unset) instead of
# $SCRIPT_NAME when deriving the theme name, and the .sh scripts run in a
# subshell so their `export BASE16_THEME=...` never reaches fish. Set it here.
if test -e ~/.base16_theme; and test -z "$BASE16_THEME"
    set -gx BASE16_THEME (basename (realpath ~/.base16_theme) .sh | string replace 'base16-' '')
end
