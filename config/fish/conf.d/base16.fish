if test -e ~/.config/base16-shell/profile_helper.fish
    source ~/.config/base16-shell/profile_helper.fish
    if not test -e ~/.base16_theme
        base16-default-dark
    end
end
