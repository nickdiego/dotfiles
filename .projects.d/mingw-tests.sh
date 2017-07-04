# std project variables
projname='mingwtests'
projpath="$HOME/sandbox/mingw-tests"
subprojects=('helloqtquick')

setenv() {
  local subproj=$1
  case $subproj in
    'helloqtquick')
      paths[src]="hello-qt-quick"
      ;;
    *)
      paths[src]="$subproj"
      ;;
  esac
  targets=('Linux-x86_64' 'Msys-x86_64')
}

activate() {
  builddir="${paths[src]}/.build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r ${paths[src]}/env.sh ] && . ${paths[src]}/env.sh $target
}

