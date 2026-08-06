# vim:ft=fish:
# Ported from dotfiles/aliases. A few entries were dropped as dead on macOS:
# icemonlab, lets-go, alert (Linux-only tools), and open=xdg-open (macOS's
# builtin `open` is already the right command, no alias needed).
abbr -a ll 'ls -alF'
abbr -a la 'ls -A'
abbr -a l 'ls -CF'
abbr -a t tmux
abbr -a psgrep 'ps aux | grep '
abbr -a fgrep 'find | grep --exclude="*~" --exclude="*.swp"'
abbr -a scpresume 'rsync --partial --progress --rsh=ssh'
abbr -a reattach-tmux 'tmux attach -tprogramming'
abbr -a shellcode 'highlight -S sh -O xterm256'
abbr -a pip_list_pkg_files 'pip list | tail -n +3 | cut -d" " -f1 | xargs pip show -f'
abbr -a fm ranger
abbr -a g rg
abbr -a vim nvim
abbr -a lg lazygit
abbr -a htop btop
abbr -a cat bat
