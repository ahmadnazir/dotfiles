# xset -b                   # disable beep

dunst ~/.config/dunst/dunstrc & # notifications
xscreensaver -no-splash &       # enabling locking

# flameshot &               # Screencapture (don't this this is needed here anymore)

# TODO: how to add the key to the agent?
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# # Opening pavucontrol was taking for ever. Fix: https://github.com/flatpak/xdg-desktop-portal-gtk/issues/72
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

exec xmonad
