#!/usr/bin/env bash
# Rofi web search - Lua config compatible

config_file="$HOME/.config/hypr/UserConfigs/01-UserDefaults.lua"

if ! command -v jq >/dev/null 2>&1; then
  notify-send -u low "Rofi Search" "jq is required for URL encoding. Please install jq."
  exit 1
fi

if [[ ! -f "$config_file" ]]; then
  notify-send -u low "Rofi Search" "Configuration file not found: $config_file"
  exit 1
fi

Search_Engine="$(
  awk -F '"' '
    /^[[:space:]]*_G\.Search_Engine[[:space:]]*=/ { print $2; exit }
    /^[[:space:]]*Search_Engine[[:space:]]*=/ { print $2; exit }
  ' "$config_file"
)"

if [[ -z "$Search_Engine" ]]; then
  notify-send -u low "Rofi Search" "Search_Engine is not set in 01-UserDefaults.lua"
  exit 1
fi

rofi_theme="$HOME/.config/rofi/config-search.rasi"
msg='‼️ **note** ‼️ search via default web browser'

pgrep -x rofi >/dev/null && pkill rofi

query="$(printf '' | rofi -dmenu -config "$rofi_theme" -mesg "$msg")"

[[ -z "$query" ]] && exit 0

encoded_query="$(printf '%s' "$query" | jq -sRr @uri)"

# Supports either:
# _G.Search_Engine = "https://www.google.com/search?q="
# OR:
# _G.Search_Engine = "https://www.google.com/search?q={}"
# OR:
# _G.Search_Engine = "https://www.google.com/search?q=%s"
if [[ "$Search_Engine" == *"{}"* ]]; then
  url="${Search_Engine/\{\}/$encoded_query}"
elif [[ "$Search_Engine" == *"%s"* ]]; then
  url="${Search_Engine/\%s/$encoded_query}"
else
  url="${Search_Engine}${encoded_query}"
fi

xdg-open "$url" >/dev/null 2>&1 &
