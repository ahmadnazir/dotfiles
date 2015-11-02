#!/bin/bash

# set single monitor
single () {
    xrandr --output HDMI1 --off --output HDMI2 --off
}
# set dual monitors
dual () {
    xrandr --output eDP1 --primary --output HDMI1 --auto --above eDP1 --output HDMI2 --off
}

triple () {
    xrandr --output eDP1 --primary --output HDMI1 --auto --above eDP1 --output HDMI2 --auto --right-of HDMI1
}


# lock the screen
lock () {
    gnome-screensaver-command --lock
}
