if not set -q IME
    set -gx IME ''
end

switch $IME
    case ibus
        set -gx GTK_IM_MODULE ibus
        set -gx XMODIFIERS '@im=ibus'
        set -gx QT_IM_MODULE ibus
    case uim
        set -gx GTK_IM_MODULE uim
        set -gx XMODIFIERS '@im=uim'
        set -gx QT_IM_MODULE uim
end
