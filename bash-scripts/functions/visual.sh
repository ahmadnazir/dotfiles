#!/bin/bash

ONE=DVI-I-1-1
TWO=DVI-I-2-2
LAPTOP=eDP-1

# set single monitor
-one-monitor () {
    restart-xmonad "basic"
    xrandr --output $LAPTOP --primary --output $ONE --off --output $TWO --off
}

-three-monitors () {
    restart-xmonad "xinerama"
    xrandr --output $LAPTOP --primary \
           --output $ONE --auto --right-of $LAPTOP \
           --output $TWO --auto --right-of $ONE
}

# hack for xmonad until I fix my display link setup
restart-xmonad () {
    rm ~/.xmonad/xmonad.state
    ln -sf /home/darkman/.xmonad/xmonad-${1}.hs /home/darkman/.xmonad/xmonad.hs
    xmonad --recompile
    xmonad --restart
}

background-init () {
    feh --bg-scale /home/darkman/code/me/dotfiles/images/bg.png
}

home () {
    -one-monitor
}

work () {
    -three-monitors
}

