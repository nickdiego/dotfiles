# Debug commands to help degugging minibrowser

define minibrowser-setup-webprocess
    set $x=0
    break WebKit::ProcessLauncher::launchProcess
    commands
        set $x++
        if ($x == 1)
            set follow-fork-mode child
        end
        continue
    end
end

define minibrowser-webprocess-reset
    set $x = 0
    set $hooked = 0
    set follow-fork-mode parent
    exec-file MiniBrowser
end

define minibrowser-hook
    minibrowser-webprocess-reset
    break MiniBrowser::MiniBrowser
    commands
        if ($hooked == 0)
            minibrowser-setup-webprocess
            minibrowser-webprocess-breakpoints
            set $hooked = 1
        end
        continue
    end
end

# Insert desired breakpoints here :)
define minibrowser-webprocess-breakpoints
#    break WebCore::RenderThemeNix::paintMediaPlayButton
#    break WebCore::RenderThemeNix::paintMediaOverlayPlayButton
#    break WebCore::RenderThemeNix::paintMediaControlsBackground
#    break WebCore::RenderMedia::RenderMedia
    break WebCore::MediaPlayer::create
end

printf "~/.gdb/minibrowser.gdb file loaded.\n"



