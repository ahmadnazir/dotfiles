#!/usr/bin/env bash
set -euo pipefail

INTERNAL="eDP-1"

LOG_DIR="$HOME/.local/state/mandark"
LOG_FILE="$LOG_DIR/ws-policy.log"
mkdir -p "$LOG_DIR"

log() {
    # echo '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> /tmp/test.log
    echo 'here we are' >> /tmp/test.log
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >>"$LOG_FILE"
}

get_external() {
  # first monitor name that isn't INTERNAL
  hyprctl monitors \
    | awk '/^Monitor /{print $2}' \
    | grep -v "^${INTERNAL}$" \
    | head -n 1 || true
}

apply_policy() {
  local ext
  ext="$(get_external)"

  log "apply_policy: internal=${INTERNAL} external=${ext:-<none>}"

  # 1–6 always on laptop
  for ws in 1 2 3 4 5 6; do
    if hyprctl dispatch moveworkspacetomonitor "$ws" "$INTERNAL" >/dev/null 2>&1; then
      log "moved workspace $ws -> $INTERNAL"
    else
      log "WARN: failed moving workspace $ws -> $INTERNAL"
    fi
  done

  if [[ -n "${ext}" ]]; then
    # external present: 7–10 on external
    for ws in 7 8 9 10; do
      if hyprctl dispatch moveworkspacetomonitor "$ws" "$ext" >/dev/null 2>&1; then
        log "moved workspace $ws -> $ext"
      else
        log "WARN: failed moving workspace $ws -> $ext"
      fi
    done
  else
    # no external: keep 7–10 on laptop
    for ws in 7 8 9 10; do
      if hyprctl dispatch moveworkspacetomonitor "$ws" "$INTERNAL" >/dev/null 2>&1; then
        log "moved workspace $ws -> $INTERNAL (no external)"
      else
        log "WARN: failed moving workspace $ws -> $INTERNAL (no external)"
      fi
    done
  fi
}

# Hyprland event socket (monitor add/remove)
SOCK="${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

log "ws-policy started (internal=${INTERNAL})"
log "socket: ${SOCK}"

# apply once at start
log "initial policy apply"
apply_policy

# re-apply on monitor hotplug events
socat -U - "UNIX-CONNECT:${SOCK}" | while read -r line; do
  case "$line" in
    monitoradded*|monitorremoved*)
      log "event: $line"
      apply_policy
      ;;
  esac
done
