#!/usr/bin/env bash

notif="$HOME/.config/swaync/images"
STATE=$(hyprctl -j getoption decoration:blur:enabled | jq -r ".bool")

if [ "$STATE" = "true" ]; then
  hyprctl eval 'hl.config({ decoration = { blur = { enabled = false } } })'
  notify-send -e -u low -i "$notif/note.png" "Blur off"
else
  hyprctl eval 'hl.config({ decoration = { blur = { enabled = true, size = 2, passes = 1, xray = false } } })'
  notify-send -e -u low -i "$notif/ja.png" "Blur on"
fi
