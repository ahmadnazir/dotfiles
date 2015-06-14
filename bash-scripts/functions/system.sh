#!/bin/bash
an-battery() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage"
}

an-flush-xmonad() {
    ps ax | grep xmonad | awk {'print $1'} | head -1 | xargs -I pid cat /proc/pid/fd/4
}

# Disable the track pad for some time after typing
an-start-syndaemon() {
	if ! pgrep "syndaemon" > /dev/null
	then
		# http://askubuntu.com/a/462661/373495
		syndaemon -i 1 -d
	fi
}
an-kill-syndaemon() {
  print ax | grep syndaemon | head -1 | awk '{print $1}' | xargs kill
}

# Backwards compatibility
battery() {
  echo "Deprecated function called: battery, Use an-battery"
  an-battery;
}
