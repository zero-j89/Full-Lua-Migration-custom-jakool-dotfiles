-- ~/.config/hypr/configs/Startup_Apps.lua

local home = os.getenv("HOME")

local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"

local function run(cmd)
  hl.exec_cmd(cmd)
end

hl.on("hyprland.start", function()
  -- Environment import
  run("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  run("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- Startup
  run(home .. "/.config/hypr/scripts/Dropterminal.sh kitty &")
  run(scriptsDir .. "/Polkit.sh")
  run("nm-applet --indicator")

  -- Clipboard manager
  run("wl-paste --type text --watch cliphist store")
  run("wl-paste --type image --watch cliphist store")

  -- Apps / services
  run("blueman-applet")
  run("qs -c overview")
  run("qs -p ~/.config/quickshell-noctalia")
  run(scriptsDir .. "/KeybindsLayoutInit.sh")
  run("systemctl --user start hyprpolkitagent")
  run("hypridle")
  run("~/.local/bin/hypr-cursor-untrap")

  -- Disabled examples:
  -- run("swww-daemon --format xrgb")
  -- run("sleep 2 && waybar")
  -- run(scriptsDir .. "/Hyprsunset.sh init")
  -- run(userScripts .. "/RainbowBorders.sh")
  -- run(scriptsDir .. "/PortalHyprland.sh")
end)