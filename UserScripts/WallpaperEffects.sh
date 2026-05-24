#!/usr/bin/env bash
# Wallpaper Effects for Noctalia WallpaperService for gzml shell
# GZML / Noctalia Wallpaper Effects
# Applies ImageMagick effects through Noctalia WallpaperService

pkill rofi 2>/dev/null || true

QS_DIR="$HOME/.config/quickshell-noctalia"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
ROFI_THEME="$HOME/.config/rofi/config-wallpaper-effect.rasi"
IDIR="$HOME/.config/swaync/images"

focused_monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"

cache_dir="$HOME/.cache/gzml/wallpaper-effects"
mkdir -p "$cache_dir"

original_file="$cache_dir/original_${focused_monitor}.txt"
wallpaper_output="$cache_dir/wallpaper_modified_${focused_monitor}.png"

current_wallpaper="$(qs -p "$QS_DIR" ipc call wallpaper get "$focused_monitor" | tail -n1)"

if [[ -z "$current_wallpaper" || ! -f "$current_wallpaper" ]]; then
    notify-send -u normal -i "$IDIR/error.png" "Wallpaper Effects" "Could not read current Noctalia wallpaper"
    exit 1
fi

# Save original only when current wallpaper is not one of our generated effect files.
# This prevents stacked effects like charcoal → sepia → negate.
if [[ "$current_wallpaper" != "$cache_dir/"* ]]; then
    printf '%s\n' "$current_wallpaper" > "$original_file"
fi

if [[ ! -f "$original_file" ]]; then
    printf '%s\n' "$current_wallpaper" > "$original_file"
fi

wallpaper_original="$(cat "$original_file")"

if [[ -z "$wallpaper_original" || ! -f "$wallpaper_original" ]]; then
    wallpaper_original="/home/zer0/Pictures/wallcard/Purple-night-sky-river.jpg"
    printf '%s\n' "$wallpaper_original" > "$original_file"
fi

declare -A effects=(
    ["No Effects"]="restore"
    ["Black & White"]="magick \"$wallpaper_original\" -colorspace gray -sigmoidal-contrast 10,40% \"$wallpaper_output\""
    ["Charcoal"]="magick \"$wallpaper_original\" -charcoal 0x5 \"$wallpaper_output\""
    ["Edge Detect"]="magick \"$wallpaper_original\" -edge 1 \"$wallpaper_output\""
    ["Emboss"]="magick \"$wallpaper_original\" -emboss 0x5 \"$wallpaper_output\""
    ["Frame Raised"]="magick \"$wallpaper_original\" +raise 150 \"$wallpaper_output\""
    ["Frame Sunk"]="magick \"$wallpaper_original\" -raise 150 \"$wallpaper_output\""
    ["Negate"]="magick \"$wallpaper_original\" -negate \"$wallpaper_output\""
    ["Oil Paint"]="magick \"$wallpaper_original\" -paint 4 \"$wallpaper_output\""
    ["Posterize"]="magick \"$wallpaper_original\" -posterize 4 \"$wallpaper_output\""
    ["Polaroid"]="magick \"$wallpaper_original\" -polaroid 0 \"$wallpaper_output\""
    ["Sepia Tone"]="magick \"$wallpaper_original\" -sepia-tone 65% \"$wallpaper_output\""
    ["Solarize"]="magick \"$wallpaper_original\" -solarize 80% \"$wallpaper_output\""
    ["Sharpen"]="magick \"$wallpaper_original\" -sharpen 0x5 \"$wallpaper_output\""
    ["Vignette"]="magick \"$wallpaper_original\" -vignette 0x3 \"$wallpaper_output\""
    ["Vignette-black"]="magick \"$wallpaper_original\" -background black -vignette 0x3 \"$wallpaper_output\""
    ["Zoomed"]="magick \"$wallpaper_original\" -gravity Center -extent 1:1 \"$wallpaper_output\""
)

choice="$(printf "%s\n" "${!effects[@]}" | LC_COLLATE=C sort | rofi -dmenu -i -config "$ROFI_THEME")"

[[ -z "$choice" ]] && exit 0

if [[ -z "${effects[$choice]+x}" ]]; then
    notify-send -u normal -i "$IDIR/error.png" "Wallpaper Effects" "Unknown effect: $choice"
    exit 1
fi

if [[ "${effects[$choice]}" == "restore" ]]; then
    qs -p "$QS_DIR" ipc call wallpaper set "$wallpaper_original" "$focused_monitor"
    rm -f "$wallpaper_output"
    wallust run "$wallpaper_original" -s
    # "$SCRIPTSDIR/Refresh.sh"
    notify-send -u low -i "$IDIR/ja.png" "Wallpaper Effects" "Restored original wallpaper"
    exit 0
fi

# gzml shell

notify-send -u normal -i "$IDIR/ja.png" "Applying Wallpaper Effect" "$choice"

rm -f "$wallpaper_output"

eval "${effects[$choice]}"

if [[ ! -f "$wallpaper_output" ]]; then
    notify-send -u normal -i "$IDIR/error.png" "Wallpaper Effects" "Failed to create modified wallpaper"
    exit 1
fi

qs -p "$QS_DIR" ipc call wallpaper set "$wallpaper_output" "$focused_monitor"

wallust run "$wallpaper_output" -s
# "$SCRIPTSDIR/Refresh.sh"

notify-send -u low -i "$IDIR/ja.png" "$choice" "Wallpaper effect applied"
