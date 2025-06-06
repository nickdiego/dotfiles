set history filename ~/.gdb_history
set history save on
set history size unlimited

set pagination 0
set follow-fork-mode parent
set breakpoint pending on
set debuginfod enabled on

define bsave
    shell rm -f ~/.gdb/brestore.txt
    set logging file ~/.gdb/brestore.txt
    set logging on
    info break
    set logging off
    # reformat on-the-fly to a valid gdb command file
    shell perl -n -e 'print "break $1\n" if /^\d+.+?(\S+)$/g' ~/.gdb/brestore.txt > ~/.gdb/brestore.gdb
end

define brestore
  source ~/.gdb/brestore.gdb
end

document bsave
  store actual breakpoints
end

document brestore
  restore breakpoints saved by bsave
end

#source ~/.gdb/minibrowser.gdb
#source ~/.gdb/drowser.gdb
#source ~/.gdb/diagnosis.gdb
#source ~/.gdb/knockout_cc.gdb
#source ~/.gdb/ollvm.gdb
source ~/.gdb/chromium.gdb
