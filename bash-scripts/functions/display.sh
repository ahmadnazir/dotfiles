#!/bin/bash

PRIMARY=eDP-1
SECONDARY=HDMI-1

primary-screen () {
    xrandr --output $PRIMARY --primary \
           --output $SECONDARY --off
    xmonad --restart
}

secondary-screen () {
    xrandr --output $SECONDARY --auto --below $PRIMARY --scale 1.4x1.4 \
           --output $PRIMARY --primary
    xmonad --restart
}

available-screens () {
    xrandr | grep ' connected' | awk '{print $1}'
}

