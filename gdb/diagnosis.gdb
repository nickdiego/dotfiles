# Debug commands to help degugging minibrowser

define diagnosis-setup
  set args --gui
end

define rerun
  diagnosis-setup
  make -j10
  run
end

printf "~/.gdb/diagnosis.gdb file loaded.\n"



