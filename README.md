# Dotfiles

Dotfiles for omarchy.

## Fixes

Sometimes the config doesn't work ... and the system misbehaves. Use the following scripts to fix:

### Screen is not mapped to the correct workspace

```
~/dotfiles/hypr/.config/hypr/scripts/remap-workspaces.sh
```

### Main monitor is frozen but secondary is working

Let's reset it:
```
~/dotfiles/hypr/.config/hypr/scripts/reset-monitor.sh
```

### Whole machine froze and needed a hard reboot

Use the `investigate-freeze` skill (`claude/.claude/skills/investigate-freeze/`) to dig through the logs for a cause.

On a new machine (or to double check an existing one), run `setup-crash-forensics` (`claude/.claude/skills/setup-crash-forensics/`) first — it enables SysRq and verifies the physical key combo actually works, so a future freeze leaves useful evidence instead of nothing.

### Fans spinning hard / a Chrome or Chromium window is hogging the CPU

```
~/dotfiles/hypr/.config/hypr/scripts/chrome-hog.sh
```

Ranks the hottest chrome/chromium processes and maps each back to the window
title that owns it (Chrome doesn't expose per-tab CPU via `ps`, only Shift+Esc
Task Manager does — this gets you close enough to know which window to check).

### System feels slow / terminal takes seconds to open after closing the lid

Framework Laptop 16 (Ryzen 7040) BIOS bug: CPU gets stuck at ~544MHz after suspend/resume until BIOS 3.07+. Fixed via firmware update (`omarchy-update-firmware` after enabling the `lvfs-testing` remote), not an OS-level setting. Full writeup and action checklist in `reports/2026-08-10-post-resume-slowness.md`.

## Reports

Point-in-time investigations of system issues live in `reports/`, each with root cause and a follow-up action checklist.
