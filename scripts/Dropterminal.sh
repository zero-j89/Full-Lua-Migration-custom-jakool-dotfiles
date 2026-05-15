#!/usr/bin/env bash
# Dropterminal.sh - Hyprland Lua-compatible dropdown terminal
#
# This script ONLY manages kitty windows with class "dropdown-terminal".
# It never falls back to the active window, so it cannot grab Brave/other apps.
#
# Usage:
#   Dropterminal.sh
#   Dropterminal.sh -d
#   Dropterminal.sh "kitty --class dropdown-terminal"

DEBUG=false
ADDR_FILE="/tmp/dropdown_terminal_addr"
DROP_CLASS="dropdown-terminal"
SPECIAL_WS="special:scratchpad"

WIDTH_PERCENT=65
HEIGHT_PERCENT=65
Y_PERCENT=10

if [ "$1" = "-d" ]; then
  DEBUG=true
  shift
fi

TERMINAL_CMD="${1:-kitty --class dropdown-terminal}"

debug() {
  if [ "$DEBUG" = true ]; then
    echo "$@"
  fi
}

lua_quote() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  printf '"%s"' "$s"
}

dispatch_lua() {
  local expr="$1"
  debug "hyprctl dispatch $expr"
  hyprctl dispatch "$expr" >/dev/null 2>&1
}

dispatch_lua_visible() {
  local expr="$1"
  debug "hyprctl dispatch $expr"
  hyprctl dispatch "$expr"
}

get_focused_monitor_info() {
  hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.x) \(.y) \(.width) \(.height) \(.scale) \(.name)"'
}

calculate_geometry() {
  local info mon_x mon_y mon_w mon_h scale mon_name
  info="$(get_focused_monitor_info)"

  if [ -z "$info" ] || [[ "$info" == "null"* ]]; then
    echo "100 100 1200 700 fallback"
    return
  fi

  mon_x="$(echo "$info" | cut -d' ' -f1)"
  mon_y="$(echo "$info" | cut -d' ' -f2)"
  mon_w="$(echo "$info" | cut -d' ' -f3)"
  mon_h="$(echo "$info" | cut -d' ' -f4)"
  scale="$(echo "$info" | cut -d' ' -f5)"
  mon_name="$(echo "$info" | cut -d' ' -f6)"

  if [ -z "$scale" ] || [ "$scale" = "null" ] || [ "$scale" = "0" ]; then
    scale="1.0"
  fi

  local logical_w logical_h
  if command -v bc >/dev/null 2>&1; then
    logical_w="$(echo "scale=0; $mon_w / $scale" | bc | cut -d'.' -f1)"
    logical_h="$(echo "scale=0; $mon_h / $scale" | bc | cut -d'.' -f1)"
  else
    logical_w="$mon_w"
    logical_h="$mon_h"
  fi

  if ! [[ "$logical_w" =~ ^-?[0-9]+$ ]]; then logical_w="$mon_w"; fi
  if ! [[ "$logical_h" =~ ^-?[0-9]+$ ]]; then logical_h="$mon_h"; fi

  local w h x y
  w=$((logical_w * WIDTH_PERCENT / 100))
  h=$((logical_h * HEIGHT_PERCENT / 100))
  x=$((mon_x + ((logical_w - w) / 2)))
  y=$((mon_y + (logical_h * Y_PERCENT / 100)))

  echo "$x $y $w $h $mon_name"
}

find_dropdown_addr() {
  if [ -f "$ADDR_FILE" ] && [ -s "$ADDR_FILE" ]; then
    local cached
    cached="$(cat "$ADDR_FILE")"
    if hyprctl clients -j | jq -e --arg ADDR "$cached" --arg CLASS "$DROP_CLASS" \
      'any(.[]; .address == $ADDR and .class == $CLASS)' >/dev/null 2>&1; then
      echo "$cached"
      return 0
    fi
  fi

  hyprctl clients -j | jq -r --arg CLASS "$DROP_CLASS" \
    '.[] | select(.class == $CLASS) | .address' | head -1
}

workspace_name_for_addr() {
  local addr="$1"
  hyprctl clients -j | jq -r --arg ADDR "$addr" \
    '.[] | select(.address == $ADDR) | .workspace.name'
}

workspace_id_for_addr() {
  local addr="$1"
  hyprctl clients -j | jq -r --arg ADDR "$addr" \
    '.[] | select(.address == $ADDR) | .workspace.id'
}

active_workspace_id() {
  hyprctl activeworkspace -j | jq -r '.id'
}

focus_addr() {
  local addr="$1"
  dispatch_lua "hl.dsp.focus({ window = \"address:$addr\" })"
}

shape_addr() {
  local addr="$1"
  local geo x y w h
  geo="$(calculate_geometry)"
  x="$(echo "$geo" | cut -d' ' -f1)"
  y="$(echo "$geo" | cut -d' ' -f2)"
  w="$(echo "$geo" | cut -d' ' -f3)"
  h="$(echo "$geo" | cut -d' ' -f4)"

  debug "shape $addr -> x=$x y=$y w=$w h=$h"

focus_addr "$addr"
sleep 0.05

 dispatch_lua "hl.dsp.window.float()"
 dispatch_lua "hl.dsp.window.resize({ x = $w, y = $h })"
 dispatch_lua "hl.dsp.window.move({ x = $x, y = $y })"
}

move_addr_to_workspace() {
  local addr="$1"
  local ws="$2"
  local follow="$3"
  dispatch_lua "hl.dsp.window.move({ workspace = $(lua_quote "$ws"), follow = $follow, window = \"address:$addr\" })"
}

spawn_dropdown() {
  debug "spawning: $TERMINAL_CMD"

  dispatch_lua_visible "hl.dsp.exec_cmd($(lua_quote "$TERMINAL_CMD"))"

  local addr=""
  for _ in $(seq 1 30); do
    sleep 0.1
    addr="$(hyprctl clients -j | jq -r --arg CLASS "$DROP_CLASS" \
      '.[] | select(.class == $CLASS) | .address' | head -1)"
    if [ -n "$addr" ] && [ "$addr" != "null" ]; then
      break
    fi
  done

  if [ -z "$addr" ] || [ "$addr" = "null" ]; then
    echo "ERROR: Could not find a window with class '$DROP_CLASS'."
    echo "Make sure the command is: kitty --class dropdown-terminal"
    exit 1
  fi

  echo "$addr" > "$ADDR_FILE"
  focus_addr "$addr"
  sleep 0.1
  shape_addr "$addr"
}

addr="$(find_dropdown_addr)"

if [ -z "$addr" ] || [ "$addr" = "null" ]; then
  spawn_dropdown
  exit 0
fi

echo "$addr" > "$ADDR_FILE"

ws_name="$(workspace_name_for_addr "$addr")"
ws_id="$(workspace_id_for_addr "$addr")"
active_ws="$(active_workspace_id)"

debug "addr=$addr ws_name=$ws_name ws_id=$ws_id active_ws=$active_ws"

if [ "$ws_name" = "$SPECIAL_WS" ]; then
  debug "showing dropdown"
  move_addr_to_workspace "$addr" "$active_ws" "true"
  sleep 0.15
  focus_addr "$addr"
  sleep 0.1
  shape_addr "$addr"
elif [ "$ws_id" = "$active_ws" ]; then
  debug "hiding dropdown"
  move_addr_to_workspace "$addr" "$SPECIAL_WS" "false"
else
  debug "moving dropdown to current workspace"
  move_addr_to_workspace "$addr" "$active_ws" "true"
  sleep 0.15
  focus_addr "$addr"
  sleep 0.1
  shape_addr "$addr"
fi
