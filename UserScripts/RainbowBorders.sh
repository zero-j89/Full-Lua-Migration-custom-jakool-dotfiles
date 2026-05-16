#!/usr/bin/env bash
# RainbowBorders.sh - Hyprland Lua-safe border cycler
#
# Requires in ~/.config/hypr/hyprland.lua:
#   require("RainbowBorderColor")
#
# Usage:
#   RainbowBorders.sh neon
#   RainbowBorders.sh rainbow
#   RainbowBorders.sh gradient_flow
#   RainbowBorders.sh wallust_random
#   RainbowBorders.sh stop
#   RainbowBorders.sh reset

HYPR_DIR="$HOME/.config/hypr"
LUA_OUT="$HYPR_DIR/RainbowBorderColor.lua"
PIDFILE="/tmp/hypr-rainbow-borders.pid"
LOGFILE="/tmp/rainbow-borders.log"

INTERVAL="${INTERVAL:-0.6}"
BORDER_SIZE="${BORDER_SIZE:-3}"

DEFAULT_ACTIVE="${DEFAULT_ACTIVE:-rgb(8A2BE2)}"
DEFAULT_INACTIVE="${DEFAULT_INACTIVE:-rgb(1a1a2e)}"

MODE="${1:-neon}"

WALLUST_SOURCES=(
  "$HOME/.config/hypr/wallust/wallust-hyprland.conf"
  "$HOME/.config/hypr/wallust-hyprland.conf"
  "$HOME/.config/wallust/colors-hyprland.conf"
  "$HOME/.cache/wallust/colors-hyprland.conf"
)

log() {
  echo "[$(date '+%H:%M:%S')] $*" >> "$LOGFILE"
}

write_lua_color() {
  local active_color="$1"
  local inactive_color="${2:-$DEFAULT_INACTIVE}"

  mkdir -p "$HYPR_DIR"

  cat > "$LUA_OUT" <<EOF
hl.config({
  general = {
    border_size = $BORDER_SIZE,
    col = {
      active_border = "$active_color",
      inactive_border = "$inactive_color",
    },
  },
})
EOF
}

reload_hypr() {
  hyprctl reload >/dev/null 2>&1 || true
}

reset_border() {
  log "reset border to $DEFAULT_ACTIVE"
  write_lua_color "$DEFAULT_ACTIVE" "$DEFAULT_INACTIVE"
  reload_hypr
}

stop_running() {
  if [ -f "$PIDFILE" ]; then
    old_pid="$(cat "$PIDFILE" 2>/dev/null)"
    if [ -n "$old_pid" ] && kill -0 "$old_pid" 2>/dev/null; then
      log "stopping pid $old_pid"
      kill "$old_pid" 2>/dev/null || true
      sleep 0.2
    fi
    rm -f "$PIDFILE"
  fi

  pkill -f "RainbowBorders.sh --loop" 2>/dev/null || true
}

to_rgb() {
  local c="$1"

  c="${c#0x}"
  c="${c#0X}"
  c="${c#\#}"

  if [ "${#c}" -eq 8 ]; then
    c="${c:2:6}"
  fi

  if ! [[ "$c" =~ ^[0-9a-fA-F]{6}$ ]]; then
    c="8A2BE2"
  fi

  echo "rgb($c)"
}

random_rgb() {
  echo "rgb($(openssl rand -hex 3))"
}

WALLUST_COLORS=()

load_wallust_colors() {
  WALLUST_COLORS=()

  local src=""
  for f in "${WALLUST_SOURCES[@]}"; do
    if [ -f "$f" ]; then
      src="$f"
      break
    fi
  done

  if [ -z "$src" ]; then
    log "no wallust file found"
    return
  fi

  log "loading wallust colors from $src"

  mapfile -t WALLUST_COLORS < <(
    grep -E '^\$color[0-9]+' "$src" | awk '
      function hex2(s){ return (length(s)==6 ? "0xff"s : ""); }
      function rgb2(r,g,b){ return sprintf("0xff%02x%02x%02x", r, g, b); }
      {
        if (match($0, /0x([0-9a-fA-F]{8})/, m)) { print "0x" m[1]; next }
        if (match($0, /#([0-9a-fA-F]{6})/, m))  { print hex2(m[1]); next }
        if (match($0, /rgb\(([0-9]+),[ ]*([0-9]+),[ ]*([0-9]+)\)/, m)) {
          print rgb2(m[1], m[2], m[3]); next
        }
      }'
  )

  log "loaded ${#WALLUST_COLORS[@]} wallust colors"
}

wallust_random_color() {
  if [ "${#WALLUST_COLORS[@]}" -gt 0 ]; then
    echo "${WALLUST_COLORS[RANDOM % ${#WALLUST_COLORS[@]}]}"
  else
    echo "0xff$(openssl rand -hex 3)"
  fi
}

NEON_COLORS=(
  "rgb(8A2BE2)"  # blueviolet
  "rgb(00D4FF)"  # cyan neon
  "rgb(FF00FF)"  # magenta
  "rgb(7DF9FF)"  # electric blue
  "rgb(B026FF)"  # neon purple
  "rgb(00FFFF)"  # aqua
  "rgb(6A00FF)"  # deep neon violet
  "rgb(FF44CC)"  # synth pink
  "rgb(00BFFF)"  # deep sky blue
  "rgb(CF00FF)"  # ultra purple
)

FLOW_COLORS=(
  "rgb(2a2a2a)"
  "rgb(5a5a5a)"
  "rgb(8a8a8a)"
  "rgb(d0d0d0)"
  "rgb(8a8a8a)"
  "rgb(5a5a5a)"
)

next_color() {
  local mode="$1"
  local idx="$2"

  case "$mode" in
    neon|neon_purple_blue)
      echo "${NEON_COLORS[$((idx % ${#NEON_COLORS[@]}))]}"
      ;;
    gradient_flow)
      if [ "${#WALLUST_COLORS[@]}" -gt 0 ]; then
        to_rgb "${WALLUST_COLORS[$((idx % ${#WALLUST_COLORS[@]}))]}"
      else
        echo "${FLOW_COLORS[$((idx % ${#FLOW_COLORS[@]}))]}"
      fi
      ;;
    wallust_random)
      to_rgb "$(wallust_random_color)"
      ;;
    rainbow|*)
      random_rgb
      ;;
  esac
}

loop_main() {
  local mode="$1"
  local idx=0

  : > "$LOGFILE"
  log "loop started mode=$mode interval=$INTERVAL"

  load_wallust_colors

  while true; do
    color="$(next_color "$mode" "$idx")"
    log "idx=$idx color=$color"
    write_lua_color "$color" "$DEFAULT_INACTIVE"
    reload_hypr

    idx=$((idx + 1))
    sleep "$INTERVAL"
  done
}

case "$MODE" in
  stop)
    stop_running
    reset_border
    log "stopped"
    exit 0
    ;;
  reset)
    reset_border
    log "reset only"
    exit 0
    ;;
  --loop)
    loop_main "${2:-neon}"
    exit 0
    ;;
  neon|neon_purple_blue|rainbow|gradient_flow|wallust_random)
    stop_running
    reset_border
    bash "$0" --loop "$MODE" >/dev/null 2>&1 &
    echo $! > "$PIDFILE"
    log "started mode=$MODE pid=$(cat "$PIDFILE")"
    exit 0
    ;;
  *)
    echo "Usage: $0 {neon|rainbow|gradient_flow|wallust_random|stop|reset}"
    exit 1
    ;;
esac
