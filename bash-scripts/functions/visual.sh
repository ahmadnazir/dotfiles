#!/bin/bash

# W1=DVI-I-1-1
# W2=DVI-I-2-2

# W1=DP-2
# W2=DP-1

W1=DP-1-2
W2=DP-2-2

# H1=DP-1-1
H1=HDMI-1

DEFAULT=eDP-1

-lap () {
    xrandr --output $DEFAULT --primary --output $W1 --off --output $W2 --off --output $H1 --off
    restart-xmonad "basic"
}

-home () {
    xrandr --output $DEFAULT --primary \
           --output $H1 --scale 1.6x1.6 --auto --right-of $DEFAULT
    restart-xmonad "home"
}

-work () {
    xrandr --output $DEFAULT --primary \
           --output $W1 --auto --right-of $DEFAULT \
           --output $W2 --auto --right-of $W1
    restart-xmonad "xinerama"
}

-work-v () {
    xrandr --output $DEFAULT --primary \
           --output $W1 --auto --above $DEFAULT
    restart-xmonad "xinerama"
}


# hack for xmonad until I fix my display link setup
restart-xmonad () {
    # rm ~/.xmonad/xmonad.state
    ln -sf /home/darkman/.xmonad/xmonad-${1}.hs /home/darkman/.xmonad/xmonad.hs
    xmonad --recompile # @todo: disable once all the environments have been compiled
    xmonad --restart
    background-init
}

background-init () {
    feh --bg-scale /home/darkman/code/me/dotfiles/images/bg.png
}

lap () {
    -lap
}

home () {
    -lap
    -home
}

work () {
    -lap
    -work
}

work-v () {
    -lap
    -work-v
}
