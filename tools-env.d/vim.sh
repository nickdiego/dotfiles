# ex: ts=4 sw=4 et filetype=sh

VIM_SESSIONS_DIR="${HOME}/.vim/sessions"
declare -a VIM_SESSIONS

# Initialize VIM_SESSIONS var
if [ -d "$VIM_SESSIONS_DIR" ]; then
    VIM_SESSIONS=( $(cd $VIM_SESSIONS_DIR; echo *) )
fi

# Open vim session
v() {
  local session=${1:-${curr_proj_vimsession}}

  if [[ -z $session ]]; then
    echo "No session passed as argument nor \$curr_proj_vimsession set!" >&2
    return 1
  fi

  eval "vim '+SessionOpen $session' '+set columns=$COLUMNS'"
}

if is_bash; then
    complete -W "${VIM_SESSIONS[*]}" v
elif is_zsh; then
    compctl -k "(${VIM_SESSIONS[*]})" v
fi
