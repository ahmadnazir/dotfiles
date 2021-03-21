#!/bin/bash


# TODO: external monitor at home
# xrandr --output HDMI-1 --scale 1.4x1.4 --output eDP-1 --primary
# xmonad --restart

# H1=HDMI-1

PRIMARY_SCREEN=eDP-1

-lap () {
    disable-secondary-screens
    # xrandr --output $PRIMARY_SCREEN --primary --output $W1 --off --output $W2 --off --output $H1 --off
    restart-xmonad "basic"
}

-home () {
    H1=HDMI-1

    disable-secondary-screens && \
    xrandr --output $PRIMARY_SCREEN --primary \
           --output $H1 --auto --right-of $PRIMARY_SCREEN
           # --scale 1.75x1.75
    restart-xmonad "home"
}

-work () {
    W1=DP-1-2
    W2=DP-2-2
    xrandr --output $PRIMARY_SCREEN --primary \
           --output $W1 --auto --right-of $PRIMARY_SCREEN \
           --output $W2 --auto --right-of $W1
    restart-xmonad "xinerama"
}

# hack for xmonad until I fix my display link setup
restart-xmonad () {
    # rm ~/.xmonad/xmonad.state
    ln -sf $HOME/.xmonad/xmonad-${1}.hs $HOME/.xmonad/xmonad.hs
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

available-screens () {
    xrandr | grep ' connected' | awk '{print $1}'
}

disable-secondary-screens () {
    xrandr | grep ' connected' | grep -v eDP-1 | awk '{print $1}' | xargs  -I % xrandr --output % --off
}
