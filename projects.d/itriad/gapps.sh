# std project variables
projname='gapps'
subprojects=('music-os' 'tools')

setenv() {
  defaultdir=root
  case $subproj in
    music-os)
      dirs[src]="src/MusicOS"
      ;;
    tools)
      dirs[src]="src/tools"
      ;;
  esac
}

activate() {
  #dirs[build]="build/$target"
  target=${targets[0]} # FIXME get from parameters

  # Call env initialization script if exists
  [ -r ${dirs[root]}/env.sh ] && . ${dirs[root]}/env.sh $target
}

