# xset -b                   # disable beep

dunst ~/.config/dunst/dunstrc & # notifications
xscreensaver -no-splash &       # enabling locking

# TODO: how to add the key to the agent?
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# github copilot requires dbus to talk to the keyring
# and env variables are not exported by default
export $(dbus-launch)
export $(gnome-keyring-daemon)

# Opening pavucontrol was taking for ever. Fix: https://github.com/flatpak/xdg-desktop-portal-gtk/issues/72
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Settings for the touchpad
DEVICE_ID=`xinput | grep -i touchpad | grep -E 'id.(..)' -o | awk -F '=' '{print $2}'`
# DEVICE_ID=9 # Apple touchpad
xinput set-prop $DEVICE_ID "libinput Tapping Enabled" 1
xinput set-prop $DEVICE_ID "libinput Natural Scrolling Enabled" 1

exec xmonad
