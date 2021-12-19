# dotfiles managed by yadm

## Linux

| Distro         | Arch   |
| Window manager | Xmonad |
| Status bar     | Xmobar |
| Notifications  | dunst  |

```
~/.provision/provision.sh
```

### Upgrading

```
yay -Syu
```

Recompile xmonad (probably needed if haskell is also updated)::

```
xmonad --recompile
```

## Windows

On WSL2, explicitly run relevant commands from the provision script mentioned
above.

Following goes to `Win+R` -> `shell:startup`:

- vcXsrv launcher
- desktop switcher hotkeys
