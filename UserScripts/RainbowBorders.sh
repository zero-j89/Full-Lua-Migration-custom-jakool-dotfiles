#!/usr/bin/env bash
# RainbowBorders.sh - Hyprland Lua-parser compatible border color cycler
#
# REQUIRED in ~/.config/hypr/hyprland.lua:
#   require("RainbowBorderColor")
#
# This script writes:
#   ~/.config/hypr/RainbowBorderColor.lua
#
# Stop it:
#   pkill -f RainbowBorders.sh

EFFECT_TYPE="rainbow"

HYPR_DIR="$HOME/.config/hypr"
LUA_OUT="$HYPR_DIR/RainbowBorderColor.lua"
WALLUST_COLORS_SOURCE="$HYPR_DIR/wallust/wallust-hyprland.conf"

INTERVAL="${INTERVAL:-0.8}"
INACTIVE_COLOR="${INACTIVE_COLOR:-rgb(1a1a2e)}"
BORDER_SIZE="${BORDER_SIZE:-3}"

WALLUST_COLORS=()

LOCKFILE="/tmp/hypr-rainbow-borders.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
  echo "RainbowBorders.sh is already running."
  exit 0
fi

hex_to_rgb_string() {
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

write_lua_color() {
  local active_color="$1"
  local inactive_color="${2:-$INACTIVE_COLOR}"

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

apply_color() {
  local active_color="$1"
  write_lua_color "$active_color" "$INACTIVE_COLOR"
  hyprctl reload >/dev/null 2>&1 || true
}

load_wallust_colors() {
  WALLUST_COLORS=()

  if [ ! -f "$WALLUST_COLORS_SOURCE" ]; then
    return
  fi

  mapfile -t WALLUST_COLORS < <(
    grep -E '^\$color[0-9]+' "$WALLUST_COLORS_SOURCE" | awk '
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
}

wallust_random_color() {
  if [ "${#WALLUST_COLORS[@]}" -gt 0 ]; then
    echo "${WALLUST_COLORS[RANDOM % ${#WALLUST_COLORS[@]}]}"
  else
    echo "0xff$(openssl rand -hex 3)"
  fi
}

MAX_POS=10
GLOW_POS=0

gradient_flow_color() {
  local pos="$1"

  if [ "${#WALLUST_COLORS[@]}" -lt 16 ]; then
    echo "0xff$(openssl rand -hex 3)"
    return
  fi

  local base="${WALLUST_COLORS[10]}"
  local grad1="${WALLUST_COLORS[14]}"
  local grad2="${WALLUST_COLORS[13]}"
  local glow="${WALLUST_COLORS[15]}"

  local d=$((pos - GLOW_POS))

  if (( d > MAX_POS / 2 )); then d=$((d - MAX_POS)); fi
  if (( d < -MAX_POS / 2 )); then d=$((d + MAX_POS)); fi

  case "${d#-}" in
    0) echo "$glow" ;;
    1) echo "$grad1" ;;
    2) echo "$grad2" ;;
    *) echo "$base" ;;
  esac
}

next_color() {
  case "$EFFECT_TYPE" in
    wallust_random)
      hex_to_rgb_string "$(wallust_random_color)"
      ;;
    gradient_flow)
      local c
      c="$(gradient_flow_color "$GLOW_POS")"
      GLOW_POS=$(( (GLOW_POS + 1) % MAX_POS ))
      hex_to_rgb_string "$c"
      ;;
    rainbow|*)
      random_rgb
      ;;
  esac
}

mkdir -p "$HYPR_DIR"
load_wallust_colors

if [ ! -f "$LUA_OUT" ]; then
  write_lua_color "rgb(8A2BE2)" "$INACTIVE_COLOR"
fi

while true; do
  active_color="$(next_color)"
  apply_color "$active_color"
  sleep "$INTERVAL"
done
