---
name: setup-crash-forensics
description: Use to prepare this machine so a future freeze/hang leaves useful evidence — enables SysRq, verifies the physical key combo actually reaches the kernel, and shows the drm.debug toggle. Run this once per machine (or after a fresh install), separately from investigate-freeze which is for after a freeze already happened.
---

Run this on a new machine, or any time you want to check the setup is still intact. It only prepares diagnostics — it doesn't investigate a freeze that already happened (see `investigate-freeze` for that).

## 1. Enable SysRq

```
cat /proc/sys/kernel/sysrq
```

If it's not `1`:
```
sudo cp <this-skill-dir>/99-sysrq.conf /etc/sysctl.d/99-sysrq.conf
sudo sysctl --system
cat /proc/sys/kernel/sysrq   # confirm it now reads 1
```

## 2. Verify the physical key combo actually works

Enabling the sysctl is not the same as confirming the keyboard actually sends the SysRq scancode — some laptop keyboards need an Fn layer, or don't map Print Screen to SysRq at all. Test this with the one command that's completely safe (no reboot, no kill, no dumps of sensitive data — it just lists supported commands to the kernel log):

1. Press **Alt + SysRq + H** (SysRq is usually shared with `Print Screen`; try `Fn+Alt+PrtScn` if the bare combo doesn't register).
2. Immediately check whether it landed:
   ```
   sudo dmesg | tail -20
   # or
   journalctl -k -n 20
   ```
3. Look for a line like `SysRq : HELP : ...` listing available commands. If it's there, the key combo works end-to-end — trust `t`/`m`/`w`/`l` and REISUB to work too. If nothing shows up:
   - Confirm the sysctl actually took (step 1).
   - Try alternate physical combos (`Fn+Alt+PrtScn`, or a dedicated SysRq key if this keyboard has one).
   - Check `sudo libinput debug-events` while pressing the key to see what scancode is actually being sent — if `KEY_SYSRQ` never appears, the keyboard/firmware isn't emitting it and the physical combo won't work regardless of the sysctl.
   - There is no Hyprland keybind on this machine currently bound to `PrtScn` (checked `bindings.lua`), so a compositor conflict is unlikely — but re-check `~/dotfiles/hypr/.config/hypr/bindings.lua` for a `PRINT` bind if this ever changes, since a screenshot tool grabbing the same key at the compositor level is the other thing that could interfere.

Once confirmed, you don't need to repeat this test — it only needs re-verifying after a keyboard/firmware change or a fresh install.

## 3. Know the `drm.debug` runtime toggle (don't leave it on)

For a live investigation, not for standing setup:
```
echo 0x6 | sudo tee /sys/module/drm/parameters/debug   # DRIVER + KMS only
# ... reproduce / observe ...
echo 0 | sudo tee /sys/module/drm/parameters/debug     # turn back off — leaving it on has real overhead
```
See `investigate-freeze` for why `0x1e` (the commonly-suggested value) is best avoided as a permanent setting — it includes the per-frame ATOMIC category.
