# System slowness after suspend/resume

**Date:** 2026-08-10
**Machine:** Framework Laptop 16 (AMD Ryzen 7040 Series), BIOS 03.05, Omarchy/Hyprland on Arch
**Symptom:** General "system feels slow" after unlocking, most noticeably a multi-second delay opening a new terminal (`SUPER+SHIFT+RETURN`). Almost never happens right after a full reboot. Happens after closing the lid (suspend), carrying the laptop, and reopening it later. A full reboot fixes it every time.

## Investigation timeline

### 1. Ruled out: classic resource exhaustion
`top`/`vmstat`/`free` showed no memory pressure, no swap use, no iowait, no thermal throttling, no D-state (blocked) processes, and DNS resolved in tens of ms. Load average briefly spiked but was mostly self-inflicted by the diagnostic commands themselves. **Not the cause.**

### 2. Red herring (partially): recurring amdgpu display bug
`journalctl -k` showed a recurring `amdgpu 0000:c1:00.0: [drm] REG_WAIT timeout ... dcn31_program_compbuf_size` warning every 1–4 hours all day — a known DCN3.1 display-core bug on this hardware that has previously caused full freezes. Timing didn't line up with the slowness complaints (last occurrence was ~3 hours before one report). **Not the cause of this symptom, but a separate, still-live freeze risk worth keeping an eye on** (see `investigate-freeze` / `setup-crash-forensics` skills).

### 3. Real bug, real contributing factor: Twingate zombie leak
`/usr/sbin/twingated` (the Twingate VPN client, `twingate.service`) leaks one "Timer thread" zombie process every ~5 minutes without reaping it. Over ~3 days uptime this had accumulated **867 zombie processes**, bloating `/proc` to 1430 entries.

Omarchy's terminal launcher (`omarchy-launch-terminal` → `omarchy-cmd-terminal-cwd`) runs `pgrep -P <active-window-pid>` synchronously *before* opening the new terminal window, to detect the right working directory. `pgrep` has to scan every entry in `/proc` to do this. Measured cost:

| | Before Twingate restart | After |
|---|---|---|
| Zombie processes | 867 | 18 |
| `/proc` entries | 1430 | 581 |
| `pgrep -P` scan time | 388ms | 226ms |
| `omarchy-cmd-terminal-cwd` time | 452ms | 260ms |

Restarting `twingate.service` roughly halved this specific latency. **Real bug, contributes to terminal-open latency, but not sufficient to explain the full slowness** — the user still saw slow terminal opens after this fix.

### 4. Root cause: CPU stuck at 544MHz after resume (Framework BIOS bug)
All 16 cores were measured at ~544MHz — *below* the kernel-reported minimum (1100MHz) and a fraction of the 5.1GHz boost max — even under a pinned, fully-loaded synthetic workload (`taskset -c 0 yes > /dev/null`). Confirmed this is not an OS-level issue:
- Cycling `scaling_governor` between `performance` and `powersave` had no effect.
- Cycling `amd_pstate` driver mode between `active` and `passive` had no effect.

Since neither the governor nor the driver mode could move the needle, the cap sits below the OS — in the EC/firmware's CPPC negotiation with the CPU, which doesn't get redone correctly after `s2idle` suspend/resume on this hardware.

This is a known, well-documented Framework Laptop 16 (Ryzen 7040) issue:
- [GitHub: Framework 16 stuck at low CPU frequencies after waking from suspend (#202)](https://github.com/FrameworkComputer/SoftwareFirmwareIssueTracker/issues/202)
- [Framework Community: CPU Frequency Stuck at 600 MHz](https://community.frame.work/t/cpu-frequency-stuck-at-600-mhz/79713)
- [Framework Community: BIOS 3.07 release notes](https://community.frame.work/t/framework-laptop-16-ryzen-7040-bios-3-07-release-stable/75370) — BIOS 3.06 (beta) introduced a "CPU stuck at 545MHz after resume" regression; **BIOS 3.07 (stable) explicitly fixed it**.

This machine is on **BIOS 03.05** — older than both the regression (3.06) and the fix (3.07), so it has never had this fix. Current latest is 4.05, which includes the fix plus later updates. (A related but separate recurrence has been reported by some users on later 4.0x builds and is still being investigated by Framework as of the GitHub issue above — not expected to affect us here since we're moving from a much older, pre-fix BIOS.)

## Root cause summary

Three independent issues were found; only the third fully explains the reported symptom:

1. **amdgpu DCN3.1 display bug** — unrelated background noise, still a freeze risk to monitor separately.
2. **Twingate zombie leak** — real bug, inflates `/proc`, adds ~200ms to every terminal-open via Omarchy's `pgrep`-based cwd detection. Worth fixing but not the main story.
3. **CPU frequency stuck at 544MHz after suspend/resume** — the actual cause of "everything feels slow after I close the lid and reopen it." Fixed upstream by Framework in BIOS 3.07; this machine is on 03.05.

## Action points

- [x] Enable the LVFS testing remote (Framework publishes 7040-series BIOS updates there, not on stable): `sudo fwupdmgr enable-remote lvfs-testing`
  - Hit a stale-mirror 404 installing `fwupd` via `omarchy-pkg-add` (`stable-mirror.omarchy.org` 404 on `fwupd`/`protobuf-c`). Fixed with `sudo pacman -Syy` (sync-only refresh, no upgrade — confirmed `-Syy` without `-u` does not upgrade installed packages) before retrying `sudo pacman -S fwupd`.
- [x] Run `omarchy-update-firmware` and confirm it offers a BIOS update to at least 3.07 (ideally latest, 4.05+)
- [x] Apply the firmware update and restart the machine
- [x] After restart, verify BIOS version: `cat /sys/class/dmi/id/bios_version` — **04.05** (was 03.05), dated 06/30/2026
- [x] Verify CPU boosts correctly: `taskset -c 0 timeout 2 yes > /dev/null; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` — **4,965,583 Hz (~5.0GHz)**, was stuck at 544,478 Hz before the fix. `amd_pstate` status `active`, governor `performance`.
- [ ] Suspend and resume the laptop (close the lid, wait, reopen) to confirm the fix holds across an actual sleep cycle, not just after a cold boot
- [ ] Confirm new-terminal open feels fast again post-resume
- [ ] Decide: report the Twingate zombie leak to Twingate support (client never reaps its own "Timer thread" children)
- [ ] Decide: whether to add a periodic (e.g. daily) `systemctl restart twingate.service` timer as a stopgap against the zombie leak recurring, or just restart manually when noticed
- [ ] If the 544MHz issue recurs even after the BIOS update, check [GitHub issue #202](https://github.com/FrameworkComputer/SoftwareFirmwareIssueTracker/issues/202) for the newer test-BIOS fix Framework engineers were preparing as of this writing, and consider volunteering to test it

## Update — 2026-08-10, post-reboot verification

BIOS updated 03.05 → **04.05** via `omarchy-update-firmware` (after enabling `lvfs-testing` and working around a stale-mirror 404 with `pacman -Syy`). Post-reboot, CPU under a pinned synthetic load hit **~5.0GHz** (vs. 544MHz stuck before), governor `performance`, `amd_pstate` `active`. This confirms the firmware fix took effect on a cold boot.

## Update — 2026-08-11, post-*suspend* verification: bug still present on 04.05

Laptop closed overnight (actual lid-close suspend, not a reboot) and reopened. Result: **CPU stuck again at ~544,000Hz under load** (three runs: 543824 / 544158 / 544235 Hz) — indistinguishable from the pre-update behavior. So BIOS 04.05 fixes the *cold-boot* case but not the actual suspend/resume trigger that's the real-world symptom.

Re-tested the `amd_pstate` active→passive→active cycle on this new BIOS (previously ruled out on 03.05, retested since firmware changed): still no effect — **544,451Hz** after cycling. Confirms this is not an OS/driver-state issue reachable from software; the cap is firmware/EC-level regardless of BIOS version tried so far.

This matches the *still-open* half of [GitHub issue #202](https://github.com/FrameworkComputer/SoftwareFirmwareIssueTracker/issues/202): a Framework engineer (quinchou77) has identified a probable root cause and is testing a **private, unreleased BIOS build** that reportedly resolves it, but as of this writing it's only available by emailing the engineer directly to volunteer — no public release yet.

### Current honest state
- No confirmed fix available via public channels (04.05 is the latest public release and does not fix the suspend case).
- Only reliable workaround remains: **reboot after noticing the slowdown** (as before this whole investigation started).
- A real fix likely requires either (a) volunteering for Framework's private test BIOS via the GitHub issue, or (b) waiting for it to be promoted to the public `lvfs`/`lvfs-testing` channel.

### Updated action points
- [x] Suspend and resume the laptop to confirm whether the fix holds — **it does not**
- [x] Re-test `amd_pstate` active/passive cycle on 04.05 — still no effect
- [x] Checked whether `amd_pstate` can be reloaded as a kernel module for a fuller reinit — no, it's built into this kernel, not a loadable module, so that avenue doesn't exist
- [ ] Decide: volunteer for Framework's private test BIOS build (comment/email via [issue #202](https://github.com/FrameworkComputer/SoftwareFirmwareIssueTracker/issues/202))
- [ ] Periodically check issue #202 for a public release of the fix
- [ ] Until fixed: reboot (not just resume) after any suspend before doing frequency-sensitive work
- [ ] **Still untested** — two no-reboot ideas were proposed but never actually tried before the machine got rebooted out of necessity: (1) a second suspend/resume cycle in a row, (2) unplug/replug AC charger post-resume. Worth trying next time it gets stuck, *before* reaching for reboot, to settle whether either is a real lighter-weight workaround.

## Update — 2026-08-11, later: no non-reboot fix found yet

Attempted to find a way to reset the stuck 544MHz state without a full reboot. Ruled out: governor cycling, `amd_pstate` active/passive cycling, module reload (not applicable — `amd_pstate` is compiled into this kernel, not a loadable module). A subsequent frequency check came back healthy (~4.9GHz), but that was because **the machine was rebooted**, not because of any lighter-weight fix — so this is a confirmation of the known cold-boot recovery, not a new workaround. The two candidate no-reboot ideas above (double-suspend, AC toggle) remain untested. **Current answer to "can I reset it without restarting": no confirmed way yet.**
