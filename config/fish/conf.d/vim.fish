set -g VIM_SESSIONS_DIR $HOME/.vim/sessions
set -g VIM_SESSIONS
if test -d $VIM_SESSIONS_DIR
    set VIM_SESSIONS (ls $VIM_SESSIONS_DIR)
end

function v
    set -l session $argv[1]
    if test -z "$session"
        set session $curr_proj_vimsession
    end
    if test -z "$session"
        echo "No session passed as argument nor \$curr_proj_vimsession set!" >&2
        return 1
    end
    nvim -S "$VIM_SESSIONS_DIR/$session"
end

complete -c v -a "$VIM_SESSIONS" -f
