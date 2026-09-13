#!/usr/bin/env bash
# Report/toggle the Bluetooth headphone profile between headset (mic-ready,
# used by voxtype) and A2DP (high-fidelity, playback only). Default connect
# profile is forced to headset-head-unit via wireplumber.conf.d so there's no
# per-recording profile-switch delay; this lets you opt into high-fidelity
# audio on demand and it'll revert to headset on the next reconnect.
#
# Usage: bt-audio-profile.sh status|toggle

set -euo pipefail

CARD="bluez_card.78_2B_64_13_AE_89"
WAYBAR_SIGNAL=11

get_profile() {
  pactl list cards | awk -v card="$CARD" '
    $0 ~ card { found=1 }
    found && /Active Profile:/ { print $3; exit }
  '
}

case "${1:-status}" in
  status)
    profile=$(get_profile)
    if [[ "$profile" == a2dp-sink* ]]; then
      echo '{"text":"","alt":"a2dp","class":"a2dp","tooltip":"Bluetooth: High-fidelity (A2DP)\nClick to switch to headset (mic-ready)"}'
    elif [[ "$profile" == headset-head-unit* ]]; then
      echo '{"text":"","alt":"headset","class":"headset","tooltip":"Bluetooth: Headset (mic-ready)\nClick to switch to high-fidelity (A2DP)"}'
    else
      echo '{"text":"","alt":"other","class":"other","tooltip":"Bluetooth profile: '"$profile"'"}'
    fi
    ;;
  toggle)
    profile=$(get_profile)
    if [[ "$profile" == a2dp-sink* ]]; then
      pactl set-card-profile "$CARD" headset-head-unit
    else
      pactl set-card-profile "$CARD" a2dp-sink
    fi
    pkill -RTMIN+"$WAYBAR_SIGNAL" waybar 2>/dev/null || true
    ;;
esac
