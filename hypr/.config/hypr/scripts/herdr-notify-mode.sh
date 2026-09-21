#!/usr/bin/env bash
# Report/toggle how the herdr-dev session announces background agent state.
# The two channels are mutually exclusive by convention here: "sound" plays
# herdr's own bell through the local client, "notify" hands the event to the
# OS notification daemon (mako) instead. Leaving both on means every finished
# agent beeps *and* pops a toast, which is what prompted splitting them.
#
# config.toml is stowed, so toggling shows up as a dirty dotfiles working
# tree -- commit whichever mode you want as the checked-in default.
#
# Usage: herdr-notify-mode.sh status|toggle

set -euo pipefail

CONFIG="$HOME/.config/herdr-dev/config.toml"
WAYBAR_SIGNAL=12

get_mode() {
  # Section-aware: [ui.sound] enabled is the source of truth for the label,
  # the toast delivery key is always rewritten alongside it.
  awk '
    /^\[/ { section = $0 }
    section == "[ui.sound]" && /^[[:space:]]*enabled[[:space:]]*=[[:space:]]*true/ { sound = 1 }
    END { print (sound ? "sound" : "notify") }
  ' "$CONFIG"
}

set_mode() {
  local sound delivery tmp
  if [[ "$1" == sound ]]; then
    sound="true"
    delivery='"off"'
  else
    sound="false"
    delivery='"system"'
  fi

  tmp=$(mktemp)
  trap 'rm -f "$tmp"' RETURN
  awk -v sound="$sound" -v delivery="$delivery" '
    /^\[/ { section = $0 }
    section == "[ui.sound]" && /^[[:space:]]*enabled[[:space:]]*=/ { print "enabled = " sound; next }
    section == "[ui.toast]" && /^[[:space:]]*delivery[[:space:]]*=/ { print "delivery = " delivery; next }
    { print }
  ' "$CONFIG" >"$tmp"
  # Write through the stow symlink rather than replacing it.
  cat "$tmp" >"$CONFIG"
}

case "${1:-status}" in
  status)
    [[ -r "$CONFIG" ]] || { echo '{"text":""}'; exit 0; }
    if [[ "$(get_mode)" == sound ]]; then
      echo '{"text":"","alt":"sound","class":"sound","tooltip":"Herdr alerts: bell (sound)\nClick to switch to desktop notifications"}'
    else
      echo '{"text":"","alt":"notify","class":"notify","tooltip":"Herdr alerts: desktop notification\nClick to switch to the bell (sound)"}'
    fi
    ;;
  toggle)
    [[ -w "$CONFIG" ]] || exit 0
    if [[ "$(get_mode)" == sound ]]; then
      set_mode notify
    else
      set_mode sound
    fi
    # Reaches attached clients too: the server flags them to re-read the
    # client-local sound config when it reloads.
    command -v herdr-dev >/dev/null 2>&1 && herdr-dev server reload-config >/dev/null 2>&1 || true
    pkill -RTMIN+"$WAYBAR_SIGNAL" waybar 2>/dev/null || true
    ;;
esac
