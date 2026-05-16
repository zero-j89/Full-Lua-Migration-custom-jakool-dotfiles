#!/usr/bin/env bash
# Rofi menu for KooL Hyprland Quick Settings (SUPER SHIFT E)
# Updated for Lua config + Lua-safe RainbowBorders controls

# Editor defaults
term="kitty"
edit="nano"

# variables
configs="$HOME/.config/hypr/configs"
UserConfigs="$HOME/.config/hypr/UserConfigs"
rofi_theme="$HOME/.config/rofi/config-edit.rasi"
msg=' ⁉️ Choose what to do ⁉️'
iDIR="$HOME/.config/swaync/images"
scriptsDir="$HOME/.config/hypr/scripts"
UserScripts="$HOME/.config/hypr/UserScripts"

show_info() {
    if [[ -f "$iDIR/info.png" ]]; then
        notify-send -i "$iDIR/info.png" "Info" "$1"
    else
        notify-send "Info" "$1"
    fi
}

show_error() {
    if [[ -f "$iDIR/error.png" ]]; then
        notify-send -i "$iDIR/error.png" "E-R-R-O-R" "$1"
    else
        notify-send "E-R-R-O-R" "$1"
    fi
}

run_script() {
    local script="$1"
    shift

    if [[ -x "$script" ]]; then
        "$script" "$@" >/dev/null 2>&1 &
    elif [[ -f "$script" ]]; then
        bash "$script" "$@" >/dev/null 2>&1 &
    else
        show_error "Missing script: $script"
        return 1
    fi
}

# Rainbow Borders submenu
# Important: this DOES NOT rename RainbowBorders.sh anymore.
# Disable calls: RainbowBorders.sh stop
# Modes call:    RainbowBorders.sh neon/rainbow/gradient_flow/wallust_random
rainbow_borders_menu() {
    local rainbow_script="$UserScripts/RainbowBorders.sh"

    if [[ ! -f "$rainbow_script" ]]; then
        show_error "RainbowBorders.sh not found in $UserScripts."
        return
    fi

    local options="Disable Rainbow Borders\nNeon Purple / Blue\nWallust Color\nOriginal Rainbow\nGradient Flow\nReset Static Border"
    local choice
    choice=$(printf "%b" "$options" | rofi -i -dmenu -config "$rofi_theme" -mesg "Rainbow Borders Mode")

    [[ -z "$choice" ]] && return

    case "$choice" in
        "Disable Rainbow Borders")
            run_script "$rainbow_script" stop
            show_info "Rainbow Borders disabled."
            ;;
        "Neon Purple / Blue")
            run_script "$rainbow_script" neon
            show_info "Rainbow Borders: Neon Purple / Blue."
            ;;
        "Wallust Color")
            run_script "$rainbow_script" wallust_random
            show_info "Rainbow Borders: Wallust Color."
            ;;
        "Original Rainbow")
            run_script "$rainbow_script" rainbow
            show_info "Rainbow Borders: Original Rainbow."
            ;;
        "Gradient Flow")
            run_script "$rainbow_script" gradient_flow
            show_info "Rainbow Borders: Gradient Flow."
            ;;
        "Reset Static Border")
            run_script "$rainbow_script" reset
            show_info "Rainbow Borders reset."
            ;;
        *)
            return
            ;;
    esac
}

menu() {
    cat <<EOF
--- USED SCRIPTS ---
Edit User Defaults
Edit User Keybinds
Edit System Default Keybinds
Edit User ENV variables
Edit User Startup Apps (overlay)
Edit System Default Startup Apps
Edit User Window Rules (overlay)
Edit System Default Window Rules
Edit User Decorations
Edit User Settings
Edit System Default Settings
--- SYSTEM SETTINGS ---
Set SDDM Wallpaper
Choose Kitty Terminal Theme
Display Manager
Configure Workspace Rules
GTK Settings
QT6 Apps Settings
QT5 Apps Settings
Choose Monitor Profiles
Choose Rofi Themes
Search for Keybinds
Rainbow Borders Mode
--- OLD UNUSED ---
Edit Old Animations
Choose Hyprland Animations
Edit User Laptop Settings Optional
EOF
}

main() {
    local choice
    local file=""

    choice=$(menu | rofi -i -dmenu -config "$rofi_theme" -mesg "$msg")

    case "$choice" in
        "Edit User Defaults") file="$UserConfigs/01-UserDefaults.lua" ;;
        "Edit User ENV variables") file="$UserConfigs/ENVariables.lua" ;;
        "Edit User Keybinds") file="$UserConfigs/UserKeybinds.lua" ;;
        "Edit User Startup Apps (overlay)") file="$UserConfigs/Startup_Apps.lua" ;;
        "Edit User Window Rules (overlay)") file="$UserConfigs/WindowRules.lua" ;;
        "Edit User Settings") file="$UserConfigs/UserSettings.lua" ;;
        "Edit User Decorations") file="$UserConfigs/UserDecorations.lua" ;;
        "Edit Old Animations") file="$UserConfigs/UserAnimations.lua" ;;
        "Edit User Laptop Settings Optional") file="$UserConfigs/Laptops.lua" ;;

        "Edit System Default Keybinds") file="$configs/Keybinds.lua" ;;
        "Edit System Default Startup Apps") file="$configs/Startup_Apps.lua" ;;
        "Edit System Default Window Rules") file="$configs/WindowRules.lua" ;;
        "Edit System Default Settings") file="$configs/SystemSettings.lua" ;;

        "Set SDDM Wallpaper")
            run_script "$scriptsDir/sddm_wallpaper.sh" --normal
            ;;

        "Choose Kitty Terminal Theme")
            run_script "$scriptsDir/Kitty_themes.sh"
            ;;

        "Display Manager"|"Configure Workspace Rules")
            if ! command -v nwg-displays &>/dev/null; then
                show_error "Install nwg-displays first"
                exit 1
            fi
            nwg-displays
            ;;

        "GTK Settings")
            if ! command -v nwg-look &>/dev/null; then
                show_error "Install nwg-look first"
                exit 1
            fi
            nwg-look
            ;;

        "QT6 Apps Settings")
            if ! command -v qt6ct &>/dev/null; then
                show_error "Install qt6ct first"
                exit 1
            fi
            qt6ct
            ;;

        "QT5 Apps Settings")
            if ! command -v qt5ct &>/dev/null; then
                show_error "Install qt5ct first"
                exit 1
            fi
            qt5ct
            ;;

        "Choose Hyprland Animations")
            run_script "$scriptsDir/Animations.sh"
            ;;

        "Choose Monitor Profiles")
            run_script "$scriptsDir/MonitorProfiles.sh"
            ;;

        "Choose Rofi Themes")
            run_script "$scriptsDir/RofiThemeSelector.sh"
            ;;

        "Search for Keybinds")
            run_script "$scriptsDir/KeyBinds.sh"
            ;;

        "Rainbow Borders Mode")
            rainbow_borders_menu
            ;;

        *)
            return
            ;;
    esac

    if [[ -n "$file" ]]; then
        if [[ ! -e "$file" ]]; then
            show_info "File does not exist yet. Opening new file: $file"
        fi
        "$term" -e "$edit" "$file"
    fi
}

if pidof rofi >/dev/null; then
    pkill rofi
fi

main
