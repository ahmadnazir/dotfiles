#!/bin/bash

# set single monitor
-one-monitor () {
    xrandr --output HDMI1 --off --output HDMI2 --off
}

# set dual monitors
-two-monitors () {
    xrandr --output eDP1 --primary --output HDMI1 --auto --above eDP1 --output HDMI2 --off
}

-three-monitors () {
    xrandr --output eDP1 --primary --output HDMI1 --auto --above eDP1 --output HDMI2 --auto --right-of HDMI1
}

home-mode () {
    three-monitors
}

office-mode () {
    three-monitors
}
