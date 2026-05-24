#!/usr/bin/env bash
# Rofi Themes - Noctalia/GZML compatible

ROFI_THEMES_DIR_CONFIG="$HOME/.config/rofi/themes"
ROFI_THEMES_DIR_LOCAL="$HOME/.local/share/rofi/themes"
ROFI_CONFIG_FILE="$HOME/.config/rofi/config.rasi"
ROFI_THEME_FOR_THIS_SCRIPT="$HOME/.config/rofi/config-rofi-theme.rasi"
IDIR="$HOME/.config/swaync/images"
QS_DIR="$HOME/.config/quickshell-noctalia"
ROFI_WALL="$HOME/.config/rofi/.current_wallpaper"

notify_user() {
  notify-send -u low -i "$1" "$2" "$3"
}

sync_noctalia_wallpaper_cache() {
  local focused_monitor wallpaper
  focused_monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
  wallpaper="$(qs -p "$QS_DIR" ipc call wallpaper get "$focused_monitor" | tail -n1)"

  if [[ -n "$wallpaper" && -f "$wallpaper" ]]; then
    mkdir -p "$HOME/.config/rofi"
    ln -sf "$wallpaper" "$ROFI_WALL"
  fi
}

apply_rofi_theme_to_config() {
  local theme_name_to_apply="$1"
  local theme_path

  if [[ -f "$ROFI_THEMES_DIR_CONFIG/$theme_name_to_apply" ]]; then
    theme_path="$ROFI_THEMES_DIR_CONFIG/$theme_name_to_apply"
  elif [[ -f "$ROFI_THEMES_DIR_LOCAL/$theme_name_to_apply" ]]; then
    theme_path="$ROFI_THEMES_DIR_LOCAL/$theme_name_to_apply"
  else
    notify_user "$IDIR/error.png" "Error" "Theme file not found: $theme_name_to_apply"
    return 1
  fi

  local theme_path_with_tilde="~${theme_path#$HOME}"
  local temp_rofi_config_file
  temp_rofi_config_file="$(mktemp)"

  cp "$ROFI_CONFIG_FILE" "$temp_rofi_config_file"
  sed -i -E 's/^(\s*@theme)/\/\/\1/' "$temp_rofi_config_file"
  echo "@theme \"$theme_path_with_tilde\"" >>"$temp_rofi_config_file"
  cp "$temp_rofi_config_file" "$ROFI_CONFIG_FILE"
  rm "$temp_rofi_config_file"

  local max_lines=10
  local total_lines
  total_lines="$(grep -c '^//\s*@theme' "$ROFI_CONFIG_FILE")"

  if [ "$total_lines" -gt "$max_lines" ]; then
    local excess=$((total_lines - max_lines))
    for ((i = 1; i <= excess; i++)); do
      sed -i '0,/^\s*\/\/@theme/{/^\s*\/\/@theme/d;}' "$ROFI_CONFIG_FILE"
    done
  fi
}

sync_noctalia_wallpaper_cache

if [ ! -d "$ROFI_THEMES_DIR_CONFIG" ] && [ ! -d "$ROFI_THEMES_DIR_LOCAL" ]; then
  notify_user "$IDIR/error.png" "E-R-R-O-R" "No Rofi themes directory found."
  exit 1
fi

if [ ! -f "$ROFI_CONFIG_FILE" ]; then
  notify_user "$IDIR/error.png" "E-R-R-O-R" "Rofi config file not found: $ROFI_CONFIG_FILE"
  exit 1
fi

original_rofi_config_content_backup="$(cat "$ROFI_CONFIG_FILE")"

mapfile -t available_theme_names < <((
  find "$ROFI_THEMES_DIR_CONFIG" -maxdepth 1 -name "*.rasi" -type f -printf "%f\n" 2>/dev/null
  find "$ROFI_THEMES_DIR_LOCAL" -maxdepth 1 -name "*.rasi" -type f -printf "%f\n" 2>/dev/null
) | sort -V -u)

if [ ${#available_theme_names[@]} -eq 0 ]; then
  notify_user "$IDIR/error.png" "No Rofi Themes" "No .rasi files found in theme directories."
  exit 1
fi

current_selection_index=0
current_active_theme_path="$(grep -oP '^\s*@theme\s*"\K[^"]+' "$ROFI_CONFIG_FILE" | tail -n1)"

if [ -n "$current_active_theme_path" ]; then
  current_active_theme_name="$(basename "$current_active_theme_path")"
  for i in "${!available_theme_names[@]}"; do
    if [[ "${available_theme_names[$i]}" == "$current_active_theme_name" ]]; then
      current_selection_index="$i"
      break
    fi
  done
fi

while true; do
  theme_to_preview_now="${available_theme_names[$current_selection_index]}"

  if ! apply_rofi_theme_to_config "$theme_to_preview_now"; then
    echo "$original_rofi_config_content_backup" >"$ROFI_CONFIG_FILE"
    notify_user "$IDIR/error.png" "Preview Error" "Failed to apply $theme_to_preview_now. Reverted."
    exit 1
  fi

  rofi_input_list=""
  for theme_name_in_list in "${available_theme_names[@]}"; do
    rofi_input_list+="$(basename "$theme_name_in_list" .rasi)\n"
  done

  chosen_index_from_rofi="$(
    echo -e "${rofi_input_list%\\n}" |
      rofi -dmenu -i \
        -format 'i' \
        -p "Rofi Theme" \
        -mesg "‼️ note ‼️ Enter: Preview || Ctrl+S: Apply &amp; Exit || Esc: Cancel" \
        -config "$ROFI_THEME_FOR_THIS_SCRIPT" \
        -selected-row "$current_selection_index" \
        -kb-custom-1 "Control+s"
  )"

  rofi_exit_code=$?

  if [ "$rofi_exit_code" -eq 0 ]; then
    if [[ "$chosen_index_from_rofi" =~ ^[0-9]+$ ]] && [ "$chosen_index_from_rofi" -lt "${#available_theme_names[@]}" ]; then
      current_selection_index="$chosen_index_from_rofi"
    fi
  elif [ "$rofi_exit_code" -eq 1 ]; then
    notify_user "$IDIR/note.png" "Rofi Theme" "Selection cancelled. Reverting."
    echo "$original_rofi_config_content_backup" >"$ROFI_CONFIG_FILE"
    break
  elif [ "$rofi_exit_code" -eq 10 ]; then
    notify_user "$IDIR/ja.png" "Rofi Theme Applied" "$(basename "$theme_to_preview_now" .rasi)"
    break
  else
    notify_user "$IDIR/error.png" "Rofi Error" "Unexpected Rofi exit ($rofi_exit_code). Reverting."
    echo "$original_rofi_config_content_backup" >"$ROFI_CONFIG_FILE"
    break
  fi
done
