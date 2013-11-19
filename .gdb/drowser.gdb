# Debug commands to help degugging drowser

define drowser-setup-webprocess
    set $x=0
    break WebKit::ProcessLauncher::launchProcess
    commands
        set $x++
        if ($x == 2)
            set follow-fork-mode child
            drowser-webprocess-breakpoints
        end
        continue
    end
end

define drowser-webprocess-reset
    set $x = 0
    set $hooked = 0
    set follow-fork-mode parent
    exec-file drowser
end

define drowser-hook
    drowser-webprocess-reset
    break main
    commands
        if ($hooked == 0)
            drowser-setup-webprocess
            set $hooked = 1
        end
        continue
    end
end

# Insert desired breakpoints here :)
define drowser-webprocess-breakpoints
#    break WebKit::UserMediaClientNix::requestUserMedia
#    break WebCore::AudioContext::AudioContext
#    break WebCore::AudioDestinationNix::render
#    break WebCore::AudioFIFO::push
#    break WebCore::AudioNodeInput::pull
#    break WebCore::AudioContext::createMediaStreamSource
#    break AudioFileReader::decodeAudioForBusCreation
#    break AudioDestination::start

#   Audiotag
    break MediaPlayer::load
end

printf "~/.gdb/drowser.gdb file loaded.\n"

