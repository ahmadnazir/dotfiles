#!/usr/bin/env bash

hyprctl keyword monitor "eDP-1, disable"
sleep 2
hyprctl keyword monitor "eDP-1, 2560x1600@60, 0x0, 1"
