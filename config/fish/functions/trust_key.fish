function trust_key
    set -l key $argv[1]
    gpg --recv-key $key
    gpg --lsign $key
end
