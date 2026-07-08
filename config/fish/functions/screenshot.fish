function screenshot
    set -l dir $outdir
    test -n "$dir"; or set dir $HOME/Pictures
    set -l name $outfile
    test -n "$name"; or set name "screenshot-"(date '+%b-%d-%y_%H:%M:%S')
    set -l viewer $imgviewer
    test -n "$viewer"; or set viewer feh
    set -l file "$dir/$name.jpg"
    test -d $dir; or mkdir -p $dir
    echo "## Select the screen region."
    echo "## Will save it in $file"
    gm import $argv $file; and $viewer $file &
end
