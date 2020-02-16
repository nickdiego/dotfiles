# vim: ts=4 sw=4 et filetype=sh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--preview="bat --theme=base16 --color=always {}"'

