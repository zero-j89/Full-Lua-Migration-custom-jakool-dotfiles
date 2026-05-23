#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="GZML Quick Cheat Sheet" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" " = " "SUPER KEY (Windows Key Button)" "(SUPER KEY)" \
" SHIFT K" "Searchable Keybinds" "(Search all Keybinds via rofi)" \
" SHIFT E" "Hyprland Hardcoded Files Menu" "" \
"" "" "" \
" enter" "Terminal" "kitty" \
" Shift enter" "DropDown Terminal" " Q to close" \
" B" "Launch Browser" "Brave" \
" A" "Desktop Overview" "AGS Overview" \
" D" "Application Launcher" "GZML + Noctalia Shell" \
" E" "Open File Manager" "Thunar" \
" S" "Google Search using rofi" "rofi" \
" X" "Clipboard Manager 1 of 2" "clipper" \
" Q" "close active window" "not kill" \
" Shift Q " "kills an active window" "kill" \
" ALT mouse scroll up/down   " "Desktop Zoom" "Desktop Magnifier" \
" Alt V" "Clipboard Manager 2 of 2" "cliphist" \
" W" "Wallpaper Selector" "Wallpaper Selector" \
" Shift O" "Change oh-my-zsh Theme" "oh-my-zsh" \
"" "Search feature is good if you forget!" "Lots of window binds!" \
"" "Remember to search music keybinds!!" "" \
"" "" "" \
" Shift M" "Rofi FreaKing Beats!" "rofi" \
"" "" "" \
" ALT C" "Cheesy Calculator(Launcher for good one)" "Works though..." \
"  S" "screenshot" "ss" \
" Shift S" "screenshot selected area" "(grim + slurp)" \
"" "" "" \
" CTRL S" "screenshot timer 5 secs " "(grim)" \
" CTRL Shift S" "screenshot timer 10 secs " "(grim)" \
"ALT S" "Screenshot active window" "active window only" \
"CTRL ALT P" "power menu" "wlogout" \
"CTRL ALT L" "screen lock" "GZML Shell" \
"CTRL ALT Del" "Hyprland Exit" "(NOTE: Hyprland Will exit immediately)" \
" Shift F" "Fullscreen" "Toggles to full screen" \
" CTL F" "Fake Fullscreen" "Toggles to fake full screen" \
" ALT L" "Toggle Dwindle | Master Layout" "Hyprland Layout" \
" SPACEBAR" "Toggle float" "single window" \
" ALT SPACEBAR" "Toggle all windows to float" "all windows" \
" ALT O" "Toggle Blur" "normal or less blur" \
" CTRL O" "Toggle Opaque ON or OFF" "on active window only" \
"" "" "" \
" CTRL R" "Rofi Themes Menu" "Choose Rofi Themes via rofi" \
" CTRL Shift R" "Rofi Themes Menu v2" "Choose Rofi Themes via Theme Selector (modified)" \
"" "" "" \
" ALT E" "Rofi Emoticons" "Emoticon" \
" H" "Launch this Quick Cheat Sheet" "" \
"" "" "" \
"Ground Zer0's Cheat Sheet" "For My Sheet Memory - Fuck The Government" ""
