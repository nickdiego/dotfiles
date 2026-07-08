set -l vim_sessions_dir $HOME/.vim/sessions
set -g VIM_SESSIONS
if test -d $vim_sessions_dir
    set VIM_SESSIONS (ls $vim_sessions_dir)
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
    vim "+SessionOpen $session" "+set columns=$COLUMNS"
end

complete -c v -a "$VIM_SESSIONS" -f
