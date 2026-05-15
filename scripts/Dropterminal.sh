#!/usr/bin/env bash
# Dropterminal.sh - Hyprland 0.55+ Lua-compatible dropdown terminal
# Keeps original idea, but replaces legacy dispatchers with Lua dispatcher calls.
#
# Usage:
#   Dropterminal.sh kitty
#   Dropterminal.sh -d kitty
#   Dropterminal.sh "kitty -e zsh"

DEBUG=false
SPECIAL_WS="special:scratchpad"
ADDR_FILE="/tmp/dropdown_terminal_addr"

WIDTH_PERCENT=65
HEIGHT_PERCENT=65
Y_PERCENT=10

if [ "$1" = "-d" ]; then
  DEBUG=true
  shift
fi

TERMINAL_CMD="$1"

debug() {
  if [ "$DEBUG" = true ]; then
    echo "$@"
  fi
}

if [ -z "$TERMINAL_CMD" ]; then
  echo "Missing terminal command. Usage: $0 [-d] <terminal_command>"
  exit 1
fi

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

win_sel() {
  local addr="$1"
  printf '"address:%s"' "$addr"
}

current_ws() {
  hyprctl activeworkspace -j | jq -r '.id'
}

get_window_geometry() {
  local addr="$1"
  hyprctl clients -j | jq -r --arg ADDR "$addr" \
    '.[] | select(.address == $ADDR) | "\(.at[0]) \(.at[1]) \(.size[0]) \(.size[1])"'
}

get_monitor_info() {
  hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.x) \(.y) \(.width) \(.height) \(.scale) \(.name)"'
}

calculate_dropdown_position() {
  local info mon_x mon_y mon_w mon_h mon_scale mon_name
  info="$(get_monitor_info)"

  if [ -z "$info" ] || [[ "$info" == "null"* ]]; then
    echo "100 100 1200 700 fallback"
    return
  fi

  mon_x="$(echo "$info" | cut -d' ' -f1)"
  mon_y="$(echo "$info" | cut -d' ' -f2)"
  mon_w="$(echo "$info" | cut -d' ' -f3)"
  mon_h="$(echo "$info" | cut -d' ' -f4)"
  mon_scale="$(echo "$info" | cut -d' ' -f5)"
  mon_name="$(echo "$info" | cut -d' ' -f6)"

  if [ -z "$mon_scale" ] || [ "$mon_scale" = "null" ] || [ "$mon_scale" = "0" ]; then
    mon_scale="1.0"
  fi

  local logical_w logical_h
  if command -v bc >/dev/null 2>&1; then
    logical_w="$(echo "scale=0; $mon_w / $mon_scale" | bc | cut -d'.' -f1)"
    logical_h="$(echo "scale=0; $mon_h / $mon_scale" | bc | cut -d'.' -f1)"
  else
    logical_w="$mon_w"
    logical_h="$mon_h"
  fi

  if ! [[ "$logical_w" =~ ^-?[0-9]+$ ]]; then logical_w="$mon_w"; fi
  if ! [[ "$logical_h" =~ ^-?[0-9]+$ ]]; then logical_h="$mon_h"; fi

  local width height x y
  width=$((logical_w * WIDTH_PERCENT / 100))
  height=$((logical_h * HEIGHT_PERCENT / 100))
  x=$((mon_x + ((logical_w - width) / 2)))
  y=$((mon_y + (logical_h * Y_PERCENT / 100)))

  echo "$x $y $width $height $mon_name"
}

get_addr() {
  if [ -f "$ADDR_FILE" ] && [ -s "$ADDR_FILE" ]; then
    cat "$ADDR_FILE"
  fi
}

addr_exists() {
  local addr="$1"
  [ -n "$addr" ] && hyprctl clients -j | jq -e --arg ADDR "$addr" 'any(.[]; .address == $ADDR)' >/dev/null 2>&1
}

addr_workspace_name() {
  local addr="$1"
  hyprctl clients -j | jq -r --arg ADDR "$addr" '.[] | select(.address == $ADDR) | .workspace.name'
}

addr_workspace_id() {
  local addr="$1"
  hyprctl clients -j | jq -r --arg ADDR "$addr" '.[] | select(.address == $ADDR) | .workspace.id'
}

focus_addr() {
  local addr="$1"
  dispatch_lua "hl.dsp.focus({ window = $(win_sel "$addr") })"
}

float_addr() {
  local addr="$1"
  dispatch_lua "hl.dsp.window.float({ action = \"enable\", window = $(win_sel "$addr") })"
}

resize_addr() {
  local addr="$1"
  local w="$2"
  local h="$3"
  dispatch_lua "hl.dsp.window.resize({ x = $w, y = $h, window = $(win_sel "$addr") })"
}

move_addr() {
  local addr="$1"
  local x="$2"
  local y="$3"
  dispatch_lua "hl.dsp.window.move({ x = $x, y = $y, window = $(win_sel "$addr") })"
}

move_addr_to_workspace() {
  local addr="$1"
  local ws="$2"
  local follow="$3"
  dispatch_lua "hl.dsp.window.move({ workspace = $(lua_quote "$ws"), follow = $follow, window = $(win_sel "$addr") })"
}

shape_addr() {
  local addr="$1"
  local pos x y w h
  pos="$(calculate_dropdown_position)"
  x="$(echo "$pos" | cut -d' ' -f1)"
  y="$(echo "$pos" | cut -d' ' -f2)"
  w="$(echo "$pos" | cut -d' ' -f3)"
  h="$(echo "$pos" | cut -d' ' -f4)"

  float_addr "$addr"
  resize_addr "$addr" "$w" "$h"
  move_addr "$addr" "$x" "$y"
}

spawn_terminal() {
  local before after new_addr
  before="$(hyprctl clients -j | jq -r '.[].address' | sort)"

  # Launch normally through Lua exec dispatcher.
  dispatch_lua_visible "hl.dsp.exec_cmd($(lua_quote "$TERMINAL_CMD"))"

  sleep 0.7

  after="$(hyprctl clients -j | jq -r '.[].address' | sort)"
  new_addr="$(comm -13 <(echo "$before") <(echo "$after") | head -1)"

  if [ -z "$new_addr" ] || [ "$new_addr" = "null" ]; then
    new_addr="$(hyprctl activewindow -j | jq -r '.address')"
  fi

  if [ -z "$new_addr" ] || [ "$new_addr" = "null" ]; then
    echo "Could not identify dropdown terminal window."
    exit 1
  fi

  echo "$new_addr" > "$ADDR_FILE"
  focus_addr "$new_addr"
  sleep 0.1
  shape_addr "$new_addr"
}

addr="$(get_addr)"

if addr_exists "$addr"; then
  ws_name="$(addr_workspace_name "$addr")"
  ws_id="$(addr_workspace_id "$addr")"
  active_ws="$(current_ws)"

  if [ "$ws_name" = "$SPECIAL_WS" ]; then
    debug "Showing dropdown from special workspace"
    move_addr_to_workspace "$addr" "$active_ws" "true"
    sleep 0.15
    focus_addr "$addr"
    sleep 0.1
    shape_addr "$addr"
  elif [ "$ws_id" = "$active_ws" ]; then
    debug "Hiding dropdown to special workspace"
    focus_addr "$addr"
    sleep 0.1
    move_addr_to_workspace "$addr" "$SPECIAL_WS" "false"
  else
    debug "Moving dropdown to current workspace"
    move_addr_to_workspace "$addr" "$active_ws" "true"
    sleep 0.15
    focus_addr "$addr"
    sleep 0.1
    shape_addr "$addr"
  fi
else
  debug "Spawning dropdown terminal"
  spawn_terminal
fi
