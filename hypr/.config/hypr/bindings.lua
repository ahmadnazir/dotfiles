-- Application bindings.
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + M", "Music", { omarchy = "or-focus spotify" })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + G", "Signal", { launch = "signal-desktop", focus = "^signal$" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian -disable-gpu --enable-wayland-ime", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })

-- Web app bindings.
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
-- o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://app.hey.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + ALT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + CTRL + G", "Google Messages", { webapp = "https://messages.google.com/web/conversations", focus = true })
-- o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
-- o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })

-- Overwrite existing bindings with hl.unbind() first if needed.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu")

-- mandark:

-- Disable keybindings
hl.unbind("SUPER + W") -- Close active window
hl.unbind("SUPER + J") -- Toggle split
hl.unbind("SUPER + K") -- Show keybindings
hl.unbind("SUPER + SPACE") -- Launch apps
hl.unbind("SUPER + P") -- Pseudo window
hl.unbind("SUPER + F") -- Full screen
hl.unbind("SUPER + ALT + F") -- Full width

-- New keybindings
o.bind("SUPER + SHIFT + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + SHIFT + C", "Close active window", hl.dsp.window.close())
o.bind("SUPER + J", "Cycle to next window", hl.dsp.window.cycle_next())
o.bind("SUPER + K", "Cycle to prev window", hl.dsp.window.cycle_next({ next = false }))
o.bind("SUPER + SPACE", "Toggle split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + SHIFT + K", "Show key bindings", "omarchy-menu-keybindings")
o.bind("SUPER + P", "Launch apps", { omarchy = 'walker -p "Start…"' })
o.bind("SUPER + PERIOD", "Zen Mode", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Focus monitor to the left / right of current
o.bind("SUPER + W", "Focus monitor left", hl.dsp.focus({ monitor = "l" }))
o.bind("SUPER + E", "Focus monitor right", hl.dsp.focus({ monitor = "r" }))
