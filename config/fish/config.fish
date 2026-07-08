set -gx EDITOR vim
set -gx VISUAL vim
set -gx MAIL /var/spool/mail/nick

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx FZF_MARKS_JUMP \cp

# Default (30ms) is too tight for manually-typed Esc-sequence keybindings
# (e.g. Alt-.) if Esc and the following key aren't pressed as an exact
# chord; readline's equivalent (keyseq-timeout) defaults to 500ms.
set -g fish_escape_delay_ms 300

# Keep a stable SSH_AUTH_SOCK symlink so tmux sessions survive SSH reconnects
# (the forwarded agent socket path changes on every reconnect otherwise).
set -l fixed_sock $HOME/.ssh/ssh_auth_sock
if test -n "$SSH_AUTH_SOCK"; and test "$SSH_AUTH_SOCK" != "$fixed_sock"; and test -S "$SSH_AUTH_SOCK"
    ln -sf "$SSH_AUTH_SOCK" "$fixed_sock"
    set -gx SSH_AUTH_SOCK "$fixed_sock"
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
end

# Machine-local overrides (not tracked in dotfiles; secrets live here).
if test -e ~/.localenv.fish
    source ~/.localenv.fish
end
