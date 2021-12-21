resources=$HOME/.Xresources
modmap=$HOME/.Xmodmap

[[ -f $resources ]] && xrdb -merge "$resources" # xterm conf
[[ -f $modmap ]] && xrdb -merge "$modmap"

xset -b                   # disable beep
dunst ~/.config/dunstrc & # notifications
flameshot &               # Screencapture
xscreensaver -no-splash & # enabling locking
exec xmonad
