---
name: investigate-freeze
description: Use when the machine froze/hung and had to be power-cycled, and you want to figure out why from the logs. Also covers setting up SysRq and drm.debug so the next freeze leaves better forensics.
---

This machine is an AMD Ryzen laptop (Radeon 780M-class iGPU, `amdgpu` driver) running Omarchy/Hyprland on Wayland. A full freeze on this hardware has one recurring known culprit: an `amdgpu` DCN3.1 display-core bug that can leave the display pipeline in a bad state after a dock/monitor disconnect, sometimes causing a hang *minutes later* rather than immediately.

## Step 1 — find the crash boundary

```
journalctl --list-boots
```

Find the last completed boot before the current one. A short gap between its LAST ENTRY and the next boot's FIRST ENTRY (seconds to a couple minutes) is consistent with a hard power-cycle rather than a clean shutdown.

Confirm it was a hard stop:
```
journalctl -b -1 | tail -20      # does it end mid-task, with no shutdown-target messages?
last -x | head -5                 # systemd/utmp tags an unclean session as "crash"
```

## Step 2 — rule out the common causes

Run all of these against the crashed boot (`-b -1`):

```
journalctl -b -1 -k | grep -iE "oom|killed process|out of memory"
journalctl -b -1 -k | grep -iE "hung task|soft lockup|hard lockup|watchdog|rcu.*stall|mce|hardware error|nmi"
journalctl -b -1 -k | grep -iE "nvme|ata[0-9]|i/o error|reset link"
ls -la /sys/fs/pstore/           # firmware-captured panic dumps, if any
coredumpctl list                  # app-level crashes — NOT the same as a system freeze
```

A silent freeze — journald's own routine writes just stop, no OOM/MCE/panic logged — points to a low-level hang (GPU/display driver or a fully stuck CPU), not a userspace problem.

## Step 3 — check the GPU-specific angle

```
journalctl -b -1 -k | grep -iE "amdgpu|REG_WAIT|DM_MST|dcn3"
```

Known bug: `amdgpu 0000:xx:00.0: [drm] REG_WAIT timeout ... dcn31_program_compbuf_size` around a dock/MST monitor disconnect. This is a display-core (hubbub) commit bug, driven by the compositor's atomic KMS commits — not by any one application's GPU usage (so a heavy Chrome tab isn't the likely trigger; Chrome's own GPU-process crashes are a separate, sandboxed failure mode that just restarts the tab, not a full freeze).

**Methodological warning from past investigations:** don't stop at the first anomaly you find. An undock event and this GPU warning showed up together once, but the system kept running fine for 21 more minutes afterward with nothing else logged — so the timing didn't actually support a direct causal link, even though it was the only anomaly in the whole boot. Check the full time gap between any candidate event and the actual freeze before concluding it's the cause. Sometimes the honest answer is "no smoking gun, this is the best available explanation" — say that rather than overfitting to the one thing the logs happen to contain.

## Step 4 — at the moment of a future freeze

If SysRq is set up (see the `setup-crash-forensics` skill — run that once per machine, separately from this one) and the keyboard still responds at all:
- `Alt+SysRq+T` — dump all task stack traces to the kernel log
- `Alt+SysRq+M` — dump memory info
- `Alt+SysRq+W` — dump only blocked/uninterruptible tasks
- REISUB sequence (`Alt+SysRq` + `R E I S U B`, few seconds apart) — safe reboot: raw keyboard, terminate, kill, sync disks, remount read-only, reboot. Much safer than holding the power button.

If SysRq isn't set up yet on this machine, run `setup-crash-forensics` first — it also verifies the physical key combo actually reaches the kernel, which enabling the sysctl alone doesn't guarantee.
