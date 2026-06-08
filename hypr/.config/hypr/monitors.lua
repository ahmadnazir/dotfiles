-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors all
-- You must relaunch Hyprland after changing any envs (use Super+Esc, then Relaunch).

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- local omarchy_gdk_scale = 2
-- local omarchy_monitor_scale = "auto"

-- Good compromise for 27" or 32" 4K monitors (but fractional!).
-- local omarchy_gdk_scale = 1.75
-- local omarchy_monitor_scale = 1.666667

-- Straight 1x setup for low-resolution displays like 1080p or 1440p.
-- local omarchy_gdk_scale = 1
-- local omarchy_monitor_scale = 1

-- Example for Framework 13 w/ 6K XDR Apple display.
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- mandark: xmonad style workspaces

for workspace = 1, 6 do
  hl.workspace_rule({ workspace = tostring(workspace), monitor = "eDP-1" })
end

-- External monitor (right)
for workspace = 7, 10 do
  hl.workspace_rule({ workspace = tostring(workspace), monitor = "DP-2" })
end
