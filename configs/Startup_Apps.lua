-- ~/.config/hypr/configs/Startup_Apps.lua

local hl = require("hyprland")
local home = os.getenv("HOME")

local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"
local lock = scriptsDir .. "/LockScreen.sh"

-- local swwwRandom = userScripts .. "/WallpaperAutoChange.sh"
-- local livewallpaper = ""
-- local wallDIR = home .. "/Pictures/wallpapers"

hl.config({
  exec_once = {
    -- Wallpaper stuff
    -- "swww-daemon --format xrgb",
    -- [[mpvpaper '*' -o "load-scripts=no no-audio --loop" ]] .. livewallpaper,
    -- swwwRandom .. " " .. wallDIR,

    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    home .. "/.config/hypr/scripts/Dropterminal.sh kitty &",
    scriptsDir .. "/Polkit.sh",
    "nm-applet --indicator",

    -- "nm-tray",
    -- "swaync",
    -- "ags",
    -- "blueman-applet",
    -- "rog-control-center",
    -- "sleep 2 && waybar",
    -- "qs -c overview",

    -- "sleep 2 && hypridle",
    -- scriptsDir .. "/Hyprsunset.sh init",

    -- Clipboard manager
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",

    -- Rainbow borders
    -- userScripts .. "/RainbowBorders.sh",

    -- Persistent wallpaper
    -- "swww-daemon --format xrgb && swww img " .. wallDIR .. "/mecha-nostalgia.png",

    -- Gnome polkit for NixOS
    -- scriptsDir .. "/Polkit-NixOS.sh",

    -- Force xdg-desktop-portal-hyprland
    -- scriptsDir .. "/PortalHyprland.sh",

    "blueman-applet",
    "qs -c overview",
    -- "sleep 2 && qs -c unit3-volume &",
    "qs -p ~/.config/quickshell-noctalia",
    scriptsDir .. "/KeybindsLayoutInit.sh",
    "systemctl --user start hyprpolkitagent",
    "hypridle",
    "~/.local/bin/hypr-cursor-untrap",

    -- "openrgb --profile \"helldivers\"",
    -- "lact gui",
    -- "sleep 5 && trcc gui",
    -- "sleep 5 trcc theme-load \"Custom_zer0\"",
  },
})