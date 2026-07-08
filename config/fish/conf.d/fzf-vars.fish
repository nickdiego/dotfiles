set -gx FZF_MARKS_JUMP \cp
bind -M insert $FZF_MARKS_JUMP fzm
bind $FZF_MARKS_JUMP fzm

set -gx FZF_DEFAULT_COMMAND 'fd --type f --exclude .git'
set -gx FZF_DEFAULT_OPTS '--reverse'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_CTRL_T_OPTS '--preview="bat --theme=base16 --color=always {}"'
