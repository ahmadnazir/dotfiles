#!/usr/bin/env bash
set -euo pipefail

INTERNAL="eDP-1"

LOG_DIR="$HOME/.local/state/mandark"
LOG_FILE="$LOG_DIR/ws-policy.log"
mkdir -p "$LOG_DIR"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >>"$LOG_FILE"
}

move_workspace_to_monitor() {
  local ws="$1"
  local monitor="$2"
  local output

  output="$(hyprctl dispatch "hl.dsp.workspace.move({ workspace = '${ws}', monitor = '${monitor}' })" 2>&1)"
  if [[ "$output" == "ok" ]]; then
    return 0
  fi

  log "WARN: failed moving workspace ${ws} -> ${monitor}: ${output}"
  return 1
}

get_external() {
  hyprctl monitors \
    | awk '/^Monitor /{print $2}' \
    | grep -v "^${INTERNAL}$" \
    | head -n 1 || true
}

log "remap-workspaces (internal=${INTERNAL})"

ext="$(get_external)"
log "external=${ext:-<none>}"

for ws in 1 2 3 4 5 6; do
  if move_workspace_to_monitor "$ws" "$INTERNAL"; then
    log "moved workspace $ws -> $INTERNAL"
  fi
done

if [[ -n "${ext}" ]]; then
  for ws in 7 8 9 10; do
    if move_workspace_to_monitor "$ws" "$ext"; then
      log "moved workspace $ws -> $ext"
    fi
  done
else
  for ws in 7 8 9 10; do
    if move_workspace_to_monitor "$ws" "$INTERNAL"; then
      log "moved workspace $ws -> $INTERNAL (no external)"
    fi
  done
fi
