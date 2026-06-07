-- ~/.config/hypr/configs/Startup_Apps.lua

local home = os.getenv("HOME")

local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"

local function run(cmd)
  hl.exec_cmd(cmd)
end

hl.on("hyprland.start", function()
  run("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  run("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

--  run(scriptsDir .. "/Polkit.sh")
  run("nm-applet --indicator")

  run("wl-paste --type text --watch cliphist store")
  run("wl-paste --type image --watch cliphist store")

  run("blueman-applet")
  run("qs -c overview")
--  run("qs -p ~/.config/quickshell-noctalia")
--  run ("noctalia")
  run("gzml-shell")
  run(scriptsDir .. "/KeybindsLayoutInit.sh")
  run("systemctl --user start hyprpolkitagent")
  run("hypridle")

  run(userScripts .. "/FixCursorDP1.sh")
  run(userScripts .. "/StartTRCC.sh")
end)



