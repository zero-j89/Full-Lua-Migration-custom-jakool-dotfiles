#!/usr/bin/env bash
# GZML Rofi Theme Selector Modified
# Uses Noctalia wallpaper cache for rofi themes.

IDIR="$HOME/.config/swaync/images"
QS_DIR="$HOME/.config/quickshell-noctalia"
ROFI_WALL="$HOME/.config/rofi/.current_wallpaper"

ROFI="$(command -v rofi)"
SED="$(command -v sed)"
MKTEMP="$(command -v mktemp)"
NOTIFY_SEND="$(command -v notify-send)"

if [ -z "$SED" ]; then
  echo "Did not find sed, script cannot continue."
  exit 1
fi

if [ -z "$MKTEMP" ]; then
  echo "Did not find mktemp, script cannot continue."
  exit 1
fi

if [ -z "$ROFI" ]; then
  echo "Did not find rofi, there is no point to continue."
  exit 1
fi

TMP_CONFIG_FILE="$($MKTEMP).rasi"
rofi_config_file="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/config.rasi"

declare -a themes
declare -a theme_names
declare -i SELECTED

sync_noctalia_wallpaper_cache() {
  local focused_monitor wallpaper
  focused_monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
  wallpaper="$(qs -p "$QS_DIR" ipc call wallpaper get "$focused_monitor" | tail -n1)"

  if [[ -n "$wallpaper" && -f "$wallpaper" ]]; then
    mkdir -p "$HOME/.config/rofi"
    ln -sf "$wallpaper" "$ROFI_WALL"
  fi
}

find_themes() {
  local directories=("$HOME/.local/share/rofi/themes" "$HOME/.config/rofi/themes")

  for TD in "${directories[@]}"; do
    if [ -d "$TD" ]; then
      for file in "$TD"/*.rasi; do
        if [ -f "$file" ] && [ ! -L "$file" ]; then
          themes+=("$file")
          theme_names+=("$(basename "${file%.*}")")
        fi
      done
    fi
  done
}

add_theme_to_config() {
  local theme_name="$1"
  local theme_path

  if [[ -f "$HOME/.local/share/rofi/themes/$theme_name.rasi" ]]; then
    theme_path="$HOME/.local/share/rofi/themes/$theme_name.rasi"
  elif [[ -f "$HOME/.config/rofi/themes/$theme_name.rasi" ]]; then
    theme_path="$HOME/.config/rofi/themes/$theme_name.rasi"
  else
    echo "Theme not found: $theme_name"
    return 1
  fi

  if [[ -L "$theme_path" ]]; then
    theme_path="$(readlink -f "$theme_path")"
  fi

  theme_path_with_tilde="~${theme_path#$HOME}"

  if ! grep -q '^\s*@theme' "$rofi_config_file"; then
    echo -e "\n\n@theme \"$theme_path_with_tilde\"" >>"$rofi_config_file"
  else
    "$SED" -i 's/^\(\s*@theme.*\)/\/\/\1/' "$rofi_config_file"
    echo "@theme \"$theme_path_with_tilde\"" >>"$rofi_config_file"
  fi

  max_lines=9
  total_lines="$(grep -c '^\s*//@theme' "$rofi_config_file")"

  if [ "$total_lines" -gt "$max_lines" ]; then
    excess=$((total_lines - max_lines))
    for i in $(seq 1 "$excess"); do
      "$SED" -i '0,/^\s*\/\/@theme/{/^\s*\/\/@theme/d;}' "$rofi_config_file"
    done
  fi
}

create_config_copy() {
  "$ROFI" -dump-config >"$TMP_CONFIG_FILE"
  "$SED" -i 's/^\s*theme:\s\+".*"\s*;//g' "$TMP_CONFIG_FILE"
}

create_theme_list() {
  for themen in "${theme_names[@]}"; do
    echo "$themen"
  done
}

select_theme() {
  local MORE_FLAGS=(-dmenu -format i -no-custom -p "Theme" -markup -config "$TMP_CONFIG_FILE" -i)
  MORE_FLAGS+=(-kb-custom-1 "Alt-a")
  MORE_FLAGS+=(-u 2,3 -a 4,5)

  local CUR="default"

  while true; do
    local RTR RES MESG THEME_FLAG

    MESG="You can preview themes by hitting <b>Enter</b>.
<b>Alt-a</b> to accept the new theme.
<b>Escape</b> to cancel
Current theme: <b>${CUR}</b>
<span weight=\"bold\" size=\"xx-small\">When setting a new theme this will override previous theme settings.</span>"

    THEME_FLAG=()
    if [ -n "${SELECTED:-}" ]; then
      THEME_FLAG=(-theme "${themes[$SELECTED]}")
    fi

    RES="$(create_theme_list | "$ROFI" "${THEME_FLAG[@]}" "${MORE_FLAGS[@]}" -cycle -selected-row "$SELECTED" -mesg "$MESG")"
    RTR=$?

    if [ "$RTR" = 10 ]; then
      return 0
    elif [ "$RTR" = 1 ] || [ "$RTR" = 65 ]; then
      return 1
    fi

    CUR="${theme_names[$RES]}"
    SELECTED="$RES"
  done
}

sync_noctalia_wallpaper_cache
find_themes

if [ ${#themes[@]} = 0 ]; then
  "$ROFI" -e "No themes found."
  exit 0
fi

create_config_copy

if select_theme && [ -n "${SELECTED:-}" ]; then
  add_theme_to_config "${theme_names[$SELECTED]}"

  selection="${theme_names[$SELECTED]}"
  if [ -n "$NOTIFY_SEND" ]; then
    notify-send -u low -i "$IDIR/ja.png" "Rofi Theme applied:" "$selection"
  fi
fi

rm -f "$TMP_CONFIG_FILE"
