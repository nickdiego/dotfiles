set -l chr_dir ~/projects/chromium

if test -d $chr_dir/scripts
    fish_add_path $chr_dir/scripts
    chr env | source
end

if test -d $chr_dir/completions
    set -ga fish_complete_path $chr_dir/completions
end
