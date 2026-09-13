---
name: omarchy-dotfiles
description: Use when troubleshooting or modifying omarchy dotfiles — hyprland, waybar, terminal configs, monitors, workspaces, or system fixes. Knows the repo layout and available fix scripts.
---

This repo manages dotfiles for an omarchy Linux desktop using GNU Stow for symlinking configs into $HOME.

Each top-level directory is a stow package (e.g. `hypr/`, `bash/`, `nvim/`). Run `./stow-all.sh` from the repo root to apply all packages.

## Fix Scripts

### Screen not mapped to the correct workspace
```
~/dotfiles/hypr/.config/hypr/scripts/remap-workspaces.sh
```

### Main monitor frozen but secondary is working
```
~/dotfiles/hypr/.config/hypr/scripts/reset-monitor.sh
```
