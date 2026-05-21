#!/usr/bin/env bash

notif="$HOME/.config/swaync/images/ja.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq -r '.str')

# Reverse layout value to reuse toggle logic. So layouts don't get swapped initially.
if [ "$1" = "init" ]; then
  if [ "$LAYOUT" = "master" ]; then
    LAYOUT="dwindle"
  else
    LAYOUT="master"
  fi
fi

case "$LAYOUT" in
"master")
  hyprctl eval "general:layout = dwindle"
  hyprctl eval "unbind = SUPER,J"
  hyprctl eval "unbind = SUPER,K"
  hyprctl eval "bind = SUPER,J,cyclenext"
  hyprctl eval "bind = SUPER,K,cyclenext,prev"
  hyprctl eval "bind = SUPER,O,togglesplit"
  notify-send -e -u low -i "$notif" " Dwindle Layout"
  ;;
"dwindle")
  hyprctl eval "general:layout = master"
  hyprctl eval "unbind = SUPER,J"
  hyprctl eval "unbind = SUPER,K"
  hyprctl eval "unbind = SUPER,O"
  hyprctl eval "bind = SUPER,J,layoutmsg,cyclenext"
  hyprctl eval "bind = SUPER,K,layoutmsg,cycleprev"
  notify-send -e -u low -i "$notif" " Master Layout"
  ;;
*) ;;
esac
