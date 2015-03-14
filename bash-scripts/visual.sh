#!/bin/bash

# set single monitor
single () {
    xrandr --output HDMI1 --off
}
# set dual monitors
dual () {
    xrandr --output eDP1 --primary --below HDMI1 --output HDMI1 --auto
}
# lock the screen
lock () {
    gnome-screensaver-command --lock
}
