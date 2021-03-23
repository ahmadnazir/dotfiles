#!/bin/bash

PRIMARY=eDP-1
SECONDARY=HDMI-1

primary-screen () {
    xrandr --output $PRIMARY --primary \
           --output $SECONDARY --off
    xmonad --restart
}

secondary-screen () {
    xrandr --output $PRIMARY --primary \
           --output $SECONDARY --auto --right-of $PRIMARY --scale 1.4x1.4
    xmonad --restart
}

available-screens () {
    xrandr | grep ' connected' | awk '{print $1}'
}

