#!/usr/bin/env bash
# Toggle only master/dwindle. Do not touch keybinds.
# GZML toggle

notif="$HOME/.config/swaync/images/ja.png"
LAYOUT="$(hyprctl -j getoption general:layout | jq -r '.str')"

case "$LAYOUT" in
  master)
    hyprctl eval 'hl.config({ general = { layout = "dwindle" } })'
    notify-send -e -u low -i "$notif" "Dwindle Layout"
    ;;
  dwindle)
    hyprctl eval 'hl.config({ general = { layout = "master" } })'
    notify-send -e -u low -i "$notif" "Master Layout"
    ;;
  *)
    notify-send -e -u normal -i "$notif" "Layout" "Unknown layout: $LAYOUT"
    exit 1
    ;;
esac
