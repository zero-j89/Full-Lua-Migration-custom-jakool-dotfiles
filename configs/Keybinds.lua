local home = os.getenv("HOME")

local mainMod = "SUPER"
local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"

local term = _G.term or "kitty"
local files = _G.files or "thunar"

local function sh(cmd)
  return cmd
    :gsub("%$scriptsDir", scriptsDir)
    :gsub("%$UserScripts", userScripts)
    :gsub("%$term", term)
    :gsub("%$files", files)
end

local function keys(mods, key)
  if mods == nil or mods == "" then
    return key
  end
  return mods .. " + " .. key
end

local function b(mods, key, dispatcher, description, flags)
  flags = flags or {}
  if description then
    flags.description = description
  end
  hl.bind(keys(mods, key), dispatcher, flags)
end

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

local function dispatch(cmd)
  return hl.dsp.exec_cmd("hyprctl dispatch " .. cmd)
end

-- Common shortcuts
b(mainMod, "B", exec([[xdg-open "https://"]]), "open default browser")
b(mainMod, "D", exec("qs -p ~/.config/quickshell-noctalia ipc call launcher toggle"), "Noctalia launcher")

-- b(mainMod, ";", exec("rofi -show drun"), "rofi launcher")
b(mainMod, "A", exec(sh("$scriptsDir/OverviewToggle.sh")), "desktop overview")
b(mainMod, "Return", exec(term), "Open terminal")
b(mainMod, "E", exec(files), "file manager")

-- Features / extras
b(mainMod, "H", exec(sh("$scriptsDir/KeyHints.sh")), "help / cheat sheet")
b(mainMod .. " + ALT", "R", exec(sh("$scriptsDir/Refresh.sh")), "refresh bar and menus")
b(mainMod .. " + ALT", "E", exec(sh("$scriptsDir/RofiEmoji.sh")), "emoji menu")
b(mainMod, "S", exec(sh("$scriptsDir/RofiSearch.sh")), "web search")
b(mainMod .. " + ALT", "O", exec(sh("$scriptsDir/ChangeBlur.sh")), "toggle blur")

b(mainMod .. " + ALT", "G", exec(sh("$scriptsDir/TogglePerformance.sh")), "toggle performance")
b(mainMod .. " + SHIFT", "G", exec([[sh -c "qs -p ~/.config/quickshell-noctalia ipc call powerProfile toggleNoctaliaPerformance && qs -p ~/.config/quickshell-noctalia ipc call notifications toggleDND"]]), "toggle performance + dnd")
b(mainMod .. " + ALT", "L", exec(sh("$scriptsDir/ChangeLayout.sh")), "toggle master/dwindle layout")
b(mainMod .. " + ALT", "V", exec(sh("$scriptsDir/ClipManager.sh")), "clipboard manager")
b(mainMod, "X", exec("qs -p ~/.config/quickshell-noctalia ipc call plugin:clipper toggle"), "Toggle Clipper")
-- b(mainMod .. " + CTRL", "R", exec(sh("$scriptsDir/RofiThemeSelector.sh")), "rofi theme selector")
-- b(mainMod .. " + CTRL + SHIFT", "R", exec(sh("pkill rofi || true && $scriptsDir/RofiThemeSelector-modified.sh")), "rofi theme selector modified")

b(mainMod .. " + SHIFT", "F", dispatch("fullscreen"), "fullscreen")
b(mainMod .. " + CTRL", "F", dispatch("fullscreen 1"), "maximize window")
b(mainMod .. " + SHIFT", "Return", exec(sh("$scriptsDir/Dropterminal.sh " .. term)), "DropDown terminal")
b(mainMod, "SPACE", hl.dsp.window.float(), "Float current window")
-- b(mainMod .. " + ALT", "SPACE", hl.dsp.workspace.toggle_all_float(), "Float all windows")

-- Desktop zooming / magnifier
-- b(mainMod .. " + ALT", "mouse_down", exec([[hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor * 2.0}')"]]), "zoom in")
-- b(mainMod .. " + ALT", "mouse_up", exec([[hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor / 2.0}')"]]), "zoom out")


-- UserScripts
b(mainMod .. " + SHIFT", "M", exec(sh("$UserScripts/RofiBeats.sh")), "online music")
b(mainMod, "W", exec("qs -p /home/zer0/.config/quickshell-noctalia ipc call plugin:wallcards toggle"), "select wallpaper")
b(mainMod .. " + CTRL", "O", dispatch("setprop active opaque toggle"), "toggle active window opacity")
b(mainMod .. " + SHIFT", "K", exec(sh("$scriptsDir/KeyBinds.sh")), "search keybinds")
b(mainMod .. " + SHIFT", "O", exec(sh("$UserScripts/ZshChangeTheme.sh")), "change oh-my-zsh theme")
b(mainMod .. " + ALT", "C", exec(sh("$UserScripts/RofiCalc.sh")), "calculato\r")

-- Move current workspaces to monitors
b(mainMod .. " + CTRL", "F9", dispatch("movecurrentworkspacetomonitor l"), "move workspace to left monitor")
b(mainMod .. " + CTRL", "F10", dispatch("movecurrentworkspacetomonitor r"), "move workspace to right monitor")
b(mainMod .. " + CTRL", "F11", dispatch("movecurrentworkspacetomonitor u"), "move workspace to up monitor")
b(mainMod .. " + CTRL", "F12", dispatch("movecurrentworkspacetomonitor d"), "move workspace to down monitor")

-- System
b("CTRL + ALT", "Delete", exec(home .. "/.config/hypr/scripts/toggle_sysmon.sh"))
b(mainMod, "Q", hl.dsp.window.close(), "close active window")
b(mainMod .. " + SHIFT", "Q", exec(sh("$scriptsDir/KillActiveProcess.sh")), "Terminate active process")
b("CTRL + ALT", "L", exec("qs -p ~/.config/quickshell-noctalia ipc call lockScreen lock"))
b("CTRL + ALT", "P", exec(sh("$scriptsDir/Wlogout.sh")), "powermenu")
b(mainMod .. " + SHIFT", "E", exec(sh("$scriptsDir/Kool_Quick_Settings.sh")), "Quick settings menu")

-- Master layout
b(mainMod .. " + CTRL", "D", dispatch("layoutmsg removemaster"), "remove master")
b(mainMod, "I", dispatch("layoutmsg addmaster"), "add master")
b(mainMod .. " + CTRL", "Return", dispatch("layoutmsg swapwithmaster"), "swap with master")

-- Dwindle layout
b(mainMod .. " + SHIFT", "I", dispatch("layoutmsg togglesplit"), "toggle split dwindle")
b(mainMod, "P", dispatch("pseudo"), "toggle pseudo dwindle")

-- Layout-aware init
hl.on("hyprland.start", function()
  hl.exec_cmd(sh("$scriptsDir/ChangeLayout.sh init"))
end)

-- Cycle windows
b("ALT", "Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, "cycle next window")

-- Special keys / hotkeys
-- b("", "xf86audioraisevolume", exec(sh("$scriptsDir/Volume.sh --inc")), "volume up", { locked = true, repeating = true })
-- b("", "xf86audiolowervolume", exec(sh("$scriptsDir/Volume.sh --dec")), "volume down", { locked = true, repeating = true })
-- b("ALT", "xf86audioraisevolume", exec(sh("$scriptsDir/Volume.sh --inc-precise")), "volume up precise", { locked = true, repeating = true })
-- b("ALT", "xf86audiolowervolume", exec(sh("$scriptsDir/Volume.sh --dec-precise")), "volume down precise", { locked = true, repeating = true })

-- b("", "xf86AudioMicMute", exec(sh("$scriptsDir/Volume.sh --toggle-mic")), "toggle mic mute", { locked = true })
-- b("", "xf86audiomute", exec(sh("$scriptsDir/Volume.sh --toggle")), "toggle mute", { locked = true })
-- b("", "xf86Sleep", exec("systemctl suspend"), "sleep", { locked = true })
-- b("", "xf86Rfkill", exec(sh("$scriptsDir/AirplaneMode.sh")), "airplane mode", { locked = true })

-- Media controls
-- b("", "xf86AudioPlayPause", exec(sh("$scriptsDir/MediaCtrl.sh --pause")), "play/pause", { locked = true })
-- b("", "xf86AudioPause", exec(sh("$scriptsDir/MediaCtrl.sh --pause")), "pause", { locked = true })
-- b("", "xf86AudioPlay", exec(sh("$scriptsDir/MediaCtrl.sh --pause")), "play", { locked = true })
-- b("", "xf86AudioNext", exec(sh("$scriptsDir/MediaCtrl.sh --nxt")), "next track", { locked = true })
-- b("", "xf86AudioPrev", exec(sh("$scriptsDir/MediaCtrl.sh --prv")), "previous track", { locked = true })
-- b("", "xf86audiostop", exec(sh("$scriptsDir/MediaCtrl.sh --stop")), "stop", { locked = true })

-- Screenshot keybindings
b(mainMod .. " + ALT", "S", exec(sh("$scriptsDir/ScreenShot.sh --now")), "screenshot now")
b(mainMod .. " + SHIFT", "S", exec(sh("$scriptsDir/ScreenShot.sh --area")), "screenshot area")
b(mainMod .. " + CTRL", "S", exec(sh("$scriptsDir/ScreenShot.sh --in5")), "screenshot in 5s")
b(mainMod .. " + CTRL + SHIFT", "S", exec(sh("$scriptsDir/ScreenShot.sh --in10")), "screenshot in 10s")
b("ALT", "S", exec(sh("$scriptsDir/ScreenShot.sh --active")), "screenshot active window")

-- Resize windows
b(mainMod .. " + SHIFT", "left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), "resize left (-50)", { repeating = true })
b(mainMod .. " + SHIFT", "right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), "resize right (+50)", { repeating = true })
b(mainMod .. " + SHIFT", "up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), "resize up (-50)", { repeating = true })
b(mainMod .. " + SHIFT", "down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), "resize down (+50)", { repeating = true })

-- Move windows
b(mainMod .. " + CTRL", "left", hl.dsp.window.move({ direction = "l" }), "move window left")
b(mainMod .. " + CTRL", "right", hl.dsp.window.move({ direction = "r" }), "move window right")
b(mainMod .. " + CTRL", "up", hl.dsp.window.move({ direction = "u" }), "move window up")
b(mainMod .. " + CTRL", "down", hl.dsp.window.move({ direction = "d" }), "move window down")

-- Swap windows
b(mainMod .. " + ALT", "left", hl.dsp.window.swap({ direction = "l" }), "swap window left")
b(mainMod .. " + ALT", "right", hl.dsp.window.swap({ direction = "r" }), "swap window right")
b(mainMod .. " + ALT", "up", hl.dsp.window.swap({ direction = "u" }), "swap window up")
b(mainMod .. " + ALT", "down", hl.dsp.window.swap({ direction = "d" }), "swap window down")


-- Group
b(mainMod, "G", hl.dsp.group.toggle({}), "toggle group")
b(mainMod, "Tab", hl.dsp.group.next({}), "Change Group Forward")
b(mainMod .. " + CTRL", "Tab", dispatch("changegroupactive"), "change active in group")
b(mainMod .. " + SHIFT", "Tab", hl.dsp.group.prev({}), "Change Group Back")

b(mainMod .. " + CTRL", "K", hl.dsp.window.move({ into_group = "l" }), "Move left into group")
b(mainMod .. " + CTRL", "L", hl.dsp.window.move({ into_group = "r" }), "Move right into group")
b(mainMod .. " + CTRL", "H", hl.dsp.window.move({ out_of_group = true }), "Move active out of group")

-- Move focus
b(mainMod, "left", hl.dsp.focus({ direction = "l" }), "focus left")
b(mainMod, "right", hl.dsp.focus({ direction = "r" }), "focus right")
b(mainMod, "up", hl.dsp.focus({ direction = "u" }), "focus up")
b(mainMod, "down", hl.dsp.focus({ direction = "d" }), "focus down")

-- Workspaces
b(mainMod, "Tab", hl.dsp.focus({ workspace = "m+1" }), "next workspace")
b(mainMod .. " + SHIFT", "Tab", hl.dsp.focus({ workspace = "m-1" }), "previous workspace")

-- Special workspace
b(mainMod .. " + SHIFT", "U", hl.dsp.window.move({ workspace = "special" }), "move to special workspace")
b(mainMod, "U", hl.dsp.workspace.toggle_special(""), "toggle special workspace")

-- Number workspace binds
for i = 1, 10 do
  local keycode = "code:" .. tostring(i + 9)
  local workspace = tostring(i)

  b(mainMod, keycode, hl.dsp.focus({ workspace = workspace }), "workspace " .. workspace)
  b(mainMod .. " + SHIFT", keycode, hl.dsp.window.move({ workspace = workspace, follow = true }), "move to workspace " .. workspace)
  b(mainMod .. " + CTRL", keycode, hl.dsp.window.move({ workspace = workspace, follow = false }), "move silently to workspace " .. workspace)
end

b(mainMod .. " + SHIFT", "bracketleft", hl.dsp.window.move({ workspace = "-1", follow = true }), "move to previous workspace")
b(mainMod .. " + SHIFT", "bracketright", hl.dsp.window.move({ workspace = "+1", follow = true }), "move to next workspace")
b(mainMod .. " + CTRL", "bracketleft", hl.dsp.window.move({ workspace = "-1", follow = false }), "move silently to previous workspace")
b(mainMod .. " + CTRL", "bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }), "move silently to next workspace")

-- Scroll through workspaces
b(mainMod, "mouse_down", hl.dsp.focus({ workspace = "e+1" }), "next workspace")
b(mainMod, "mouse_up", hl.dsp.focus({ workspace = "e-1" }), "previous workspace")
b(mainMod, "period", hl.dsp.focus({ workspace = "e+1" }), "next workspace")
b(mainMod, "comma", hl.dsp.focus({ workspace = "e-1" }), "previous workspace")


-- Mouse move / resize
b(mainMod, "mouse:272", hl.dsp.window.drag(), "move window", { mouse = true })
b(mainMod, "mouse:273", hl.dsp.window.resize(), "resize window", { mouse = true })

b("", "code:123", exec("~/.config/hypr/scripts/Volume.sh --inc"), "volume up", { locked = true, repeating = true })
b("", "code:121", exec(sh("$scriptsDir/Volume.sh --toggle")), "toggle mute", { locked = true })
b("", "code:122", exec(sh("$scriptsDir/Volume.sh --dec")), "volume down", { locked = true, repeating = true })
b("ALT", "code:122", exec(sh("$scriptsDir/Volume.sh --dec-precise")), "volume down precise", { locked = true, repeating = true })
b("", "code:174", exec(sh("$scriptsDir/MediaCtrl.sh --stop")), "stop", { locked = true })


--  Steam Custom
b(mainMod .. " + SHIFT", "N",
  exec("~/.config/hypr/UserScripts/LaunchSteamWorkspace5.sh")
)
