#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 384x1680 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-2 --off

xrandr --output HDMI-1 --scale 1.4x1.4
