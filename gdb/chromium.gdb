source ~/projects/chromium/src/tools/gdb/gdbinit

python
import sys
sys.path.insert(1, "/home/nick/projects/chromium/src/tools/gdb/")
import gdb_chrome
end

printf "~/.gdb/chromium.gdb file loaded.\n"
