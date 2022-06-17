resources=$HOME/.Xresources
modmap=$HOME/.Xmodmap

[[ -f $resources ]] && xrdb -merge "$resources" # xterm conf
[[ -f $modmap ]] && xrdb -merge "$modmap"

xset -b                   # disable beep
dunst ~/.config/dunstrc & # notifications
flameshot &               # Screencapture
xscreensaver -no-splash & # enabling locking

# TODO: how to add the key to the agent?
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa 

exec xmonad
