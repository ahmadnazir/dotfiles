#!/bin/bash


ONE=DVI-I-1-1
TWO=DVI-I-2-2
LAPTOP=eDP-1

# set single monitor
-one-monitor () {
    # xrandr --output $ONE --off --output $TWO --off
    xrandr --output $LAPTOP --primary --output $ONE --off --output $TWO --off
}

-three-monitors () {
    # xrandr --output $LAPTOP --primary --output $TWO --auto --left-of $LAPTOP --output $ONE --auto --left-of $TWO
    xrandr --output $LAPTOP --primary
    xrandr --output $TWO --auto --left-of $LAPTOP
    xrandr --output $ONE --auto --left-of $TWO
}

home-mode () {
    -one-monitor
}

office-mode () {
    -three-monitors
}
