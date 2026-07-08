# vim: ts=4 sw=4 et filetype=sh

# IME settings
export IME="${IME:-}"
case $IME in
  ibus)
    export GTK_IM_MODULE='ibus'
    export XMODIFIERS='@im=ibus'
    export QT_IM_MODULE='ibus'
    ;;
  uim)
    export GTK_IM_MODULE='uim'
    export XMODIFIERS='@im=uim'
    export QT_IM_MODULE='uim'
    ;;
esac

