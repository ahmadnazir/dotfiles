#!/usr/bin/env bash
# Find which Chrome/Chromium window is hogging CPU (and thus spinning the fans).
#
# Chrome doesn't expose "which tab" via ps — a window's title is only known to
# the browser process that owns it. So this walks each hot process's ancestry
# up to a PID Hyprland has a window title for, and reports that.

# No `-e`: this script repeatedly `ps -p <pid>` on Chrome helper processes
# that spawn/die constantly, so a "no such process" is expected and must not
# be fatal (with -e, a failed command substitution silently kills the script).
set -uo pipefail

TOP_N="${1:-15}"

# short_label ARGS -> a short human label instead of the full (huge) command line.
short_label() {
  local args="$1"
  local browser="chrome"
  echo "$args" | grep -q "/chromium" && browser="chromium"
  case "$args" in
    *--type=renderer*--extension-process*) echo "$browser renderer (extension)" ;;
    *--type=renderer*)                     echo "$browser renderer" ;;
    *--type=gpu-process*)                  echo "$browser gpu-process" ;;
    *--type=zygote*)                       echo "$browser zygote" ;;
    *--type=utility*)
      sub=$(echo "$args" | grep -oP -- '--utility-sub-type=\K[^ ]+' | sed -E 's/.*\.mojom\.//')
      echo "$browser utility${sub:+:$sub}"
      ;;
    *--type=*)
      echo "$browser $(echo "$args" | grep -oP -- '--type=\K[^ ]+')"
      ;;
    *) echo "$browser (main window process)" ;;
  esac
}

echo "=== Top CPU processes (chrome/chromium) ==="
printf "%-8s %6s  %-10s  %s\n" "PID" "CPU%" "ETIME" "WHAT"
while read -r pid ppid cpu etime rest; do
  printf "%-8s %5s%%  %-10s  %s\n" "$pid" "$cpu" "$etime" "$(short_label "$rest")"
done < <(ps -eo pid,ppid,pcpu,etime,args \
  | grep -E "chrome|chromium" \
  | grep -Ev "grep|chrome-hog" \
  | sort -k3 -rn \
  | head -n "$TOP_N")

echo
echo "=== Likely culprit window(s) ==="

if ! command -v hyprctl >/dev/null 2>&1; then
  echo "hyprctl not found — can't map processes to window titles on this session."
  exit 0
fi

# ancestor_with_window PID -> prints the first ancestor PID (walking up parents)
# that hyprctl knows a window title for.
ancestor_with_window() {
  local pid="$1"
  local windows="$2"
  for _ in $(seq 1 10); do
    if [ -z "$pid" ] || [ "$pid" = "0" ]; then return; fi
    local title
    title=$(echo "$windows" | awk -F'\t' -v p="$pid" '$1==p {print $2 " | " $3; exit}')
    if [ -n "$title" ]; then
      echo "$pid|$title"
      return
    fi
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
  done
}

# full_process_tree PID -> the pid itself plus every descendant, one per line.
full_process_tree() {
  local pid="$1"
  echo "$pid"
  for child in $(ps -o pid= --ppid "$pid" 2>/dev/null); do
    full_process_tree "$child"
  done
}

windows=$(hyprctl clients -j | python3 -c '
import json,sys
for c in json.load(sys.stdin):
    print(str(c.get("pid")) + "\t" + str(c.get("class")) + "\t" + str(c.get("title")))
')

declare -A win_title
declare -A win_cpu

while read -r pid cpu _; do
  result=$(ancestor_with_window "$pid" "$windows")
  [ -z "$result" ] && continue
  win_pid="${result%%|*}"
  [ -n "${win_title[$win_pid]:-}" ] && continue
  win_title[$win_pid]="${result#*|}"
  tree_cpu=0
  for tpid in $(full_process_tree "$win_pid"); do
    p=$(ps -o pcpu= -p "$tpid" 2>/dev/null | tr -d ' ')
    [ -n "$p" ] && tree_cpu=$(awk -v a="$tree_cpu" -v b="$p" 'BEGIN{print a+b}')
  done
  win_cpu[$win_pid]="$tree_cpu"
done < <(ps -eo pid,pcpu,args \
  | grep -E "chrome|chromium" \
  | grep -Ev "grep|chrome-hog" \
  | sort -k2 -rn \
  | head -n "$TOP_N")

for win_pid in "${!win_cpu[@]}"; do
  echo "${win_cpu[$win_pid]} $win_pid ${win_title[$win_pid]}"
done | sort -rn | awk '{printf "PID %-8s ~%5s%% CPU across its processes  window: %s\n", $2, $1, substr($0, index($0,$3))}'

echo
echo "=== Thermals ==="
sensors 2>/dev/null | grep -E "^(fan|cpu@|edge:|Tctl)" || echo "sensors not available (install lm_sensors)"

echo
echo "Tip: for the definitive answer, focus the window and open Chrome's own"
echo "Task Manager (Shift+Esc) — it lists CPU per-tab by title directly."
