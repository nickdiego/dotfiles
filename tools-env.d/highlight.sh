### Terminal Syntax Highlighting

# from https://gist.github.com/textarcana/4611277
# Setup: "sudo apt-get install highlight"

# Pipe Highlight to less
#export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style solarized-light"
#export LESS=" -R"
alias hless='less -m -N -g -i -J --underline-special'
alias hmore='less'

# Use "highlight" in place of "cat"
alias hcat="highlight $1 --out-format xterm256 --quiet --force --style solarized-light"

# Setup JSON Syntax Highlighting
# Copy js.lang to json.lang with the following command
# cp "$(dirname $(brew list highlight | head -n 1))/share/highlight/langDefs/js.lang" "$(dirname $(brew list highlight | head -n 1))/share/highlight/langDefs/json.lang"

