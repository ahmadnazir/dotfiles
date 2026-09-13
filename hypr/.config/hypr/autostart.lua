-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Force a relayout a few seconds after boot: right at boot, eDP-1 and DP-2
-- both do their first atomic commit around the same time, and DP-2's
-- "auto" position (computed from eDP-1's geometry) can land stale before
-- eDP-1 itself has settled. One reload isn't reliably enough to converge -
-- observed needing several passes - so retry a few times with short gaps.
o.exec_on_start("sleep 5 && for i in 1 2 3 4; do hyprctl reload; sleep 1; done")
