local hl = require("hyprland")
local home = os.getenv("HOME")

local mainMod = "SUPER"
local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"

local term = _G.term or "kitty"
local files = _G.files or "dolphin"

local function sh(cmd)
  return cmd
    :gsub("%$scriptsDir", scriptsDir)
    :gsub("%$UserScripts", userScripts)
    :gsub("%$term", term)
    :gsub("%$files", files)
end

hl.config({
  bindd = {
    { mainMod, "B", "open default browser", "exec", [[xdg-open "https://"]] },
    { mainMod, "D", "Noctalia launcher", "exec", "qs -p ~/.config/quickshell-noctalia ipc call launcher toggle" },
    { mainMod, "A", "desktop overview", "exec", sh("$scriptsDir/OverviewToggle.sh") },
    { mainMod, "Return", "Open terminal", "exec", term },
    { mainMod, "E", "file manager", "exec", files },

    { mainMod, "H", "help / cheat sheet", "exec", sh("$scriptsDir/KeyHints.sh") },
    { mainMod .. " ALT", "R", "refresh bar and menus", "exec", sh("$scriptsDir/Refresh.sh") },
    { mainMod .. " ALT", "E", "emoji menu", "exec", sh("$scriptsDir/RofiEmoji.sh") },
    { mainMod, "S", "web search", "exec", sh("$scriptsDir/RofiSearch.sh") },
    { mainMod .. " ALT", "O", "toggle blur", "exec", sh("$scriptsDir/ChangeBlur.sh") },

    { mainMod .. " ALT", "G", "toggle performance", "exec", sh("$scriptsDir/TogglePerformance.sh") },
    { mainMod .. " SHIFT", "G", "toggle performance + dnd", "exec", [[sh -c "qs -p ~/.config/quickshell-noctalia ipc call powerProfile toggleNoctaliaPerformance && qs -p ~/.config/quickshell-noctalia ipc call notifications toggleDND"]] },
    { mainMod .. " ALT", "L", "toggle master/dwindle layout", "exec", sh("$scriptsDir/ChangeLayout.sh") },
    { mainMod .. " ALT", "V", "clipboard manager", "exec", sh("$scriptsDir/ClipManager.sh") },
    { mainMod, "X", "Toggle Clipper", "exec", "qs -p ~/.config/quickshell-noctalia ipc call plugin:clipper toggle" },
    { mainMod .. " CTRL", "R", "rofi theme selector", "exec", sh("$scriptsDir/RofiThemeSelector.sh") },
    { mainMod .. " CTRL SHIFT", "R", "rofi theme selector modified", "exec", sh("pkill rofi || true && $scriptsDir/RofiThemeSelector-modified.sh") },

    { mainMod .. " SHIFT", "F", "fullscreen", "fullscreen", "" },
    { mainMod .. " CTRL", "F", "maximize window", "fullscreen", "1" },
    { mainMod, "SPACE", "Float current window", "togglefloating", "" },
    { mainMod .. " ALT", "SPACE", "Float all windows", "exec", "hyprctl dispatch workspaceopt allfloat" },
    { mainMod .. " SHIFT", "Return", "DropDown terminal", "exec", sh("$scriptsDir/Dropterminal.sh " .. term) },

    { mainMod .. " ALT", "mouse_down", "zoom in", "exec", [[hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor * 2.0}')"]] },
    { mainMod .. " ALT", "mouse_up", "zoom out", "exec", [[hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor / 2.0}')"]] },

    { mainMod .. " SHIFT", "M", "online music", "exec", sh("$UserScripts/RofiBeats.sh") },
    { mainMod, "W", "select wallpaper", "exec", "qs -p /home/zer0/.config/quickshell-noctalia ipc call plugin:wallcards toggle" },
    { mainMod .. " CTRL", "O", "toggle active window opacity", "setprop", "active opaque toggle" },
    { mainMod .. " SHIFT", "K", "search keybinds", "exec", sh("$scriptsDir/KeyBinds.sh") },
    { mainMod .. " SHIFT", "O", "change oh-my-zsh theme", "exec", sh("$UserScripts/ZshChangeTheme.sh") },
    { mainMod .. " ALT", "C", "calculator", "exec", sh("$UserScripts/RofiCalc.sh") },

    { mainMod .. " CTRL", "F9", "move workspace to left monitor", "movecurrentworkspacetomonitor", "l" },
    { mainMod .. " CTRL", "F10", "move workspace to right monitor", "movecurrentworkspacetomonitor", "r" },
    { mainMod .. " CTRL", "F11", "move workspace to up monitor", "movecurrentworkspacetomonitor", "u" },
    { mainMod .. " CTRL", "F12", "move workspace to down monitor", "movecurrentworkspacetomonitor", "d" },

    { mainMod, "Q", "close active window", "killactive", "" },
    { mainMod .. " SHIFT", "Q", "Terminate active process", "exec", sh("$scriptsDir/KillActiveProcess.sh") },
    { "CTRL ALT", "P", "powermenu", "exec", sh("$scriptsDir/Wlogout.sh") },
    { mainMod .. " SHIFT", "E", "Quick settings menu", "exec", sh("$scriptsDir/Kool_Quick_Settings.sh") },

    { mainMod .. " CTRL", "D", "remove master", "layoutmsg", "removemaster" },
    { mainMod, "I", "add master", "layoutmsg", "addmaster" },
    { mainMod .. " CTRL", "Return", "swap with master", "layoutmsg", "swapwithmaster" },

    { mainMod .. " SHIFT", "I", "toggle split dwindle", "layoutmsg", "togglesplit" },
    { mainMod, "P", "toggle pseudo dwindle", "pseudo", "" },

    { "ALT", "tab", "cycle next window", "cyclenext", "" },
    { "ALT", "tab", "bring active to top", "bringactivetotop", "" },

    { mainMod .. " ALT", "S", "screenshot now", "exec", sh("$scriptsDir/ScreenShot.sh --now") },
    { mainMod .. " SHIFT", "S", "screenshot area", "exec", sh("$scriptsDir/ScreenShot.sh --area") },
    { mainMod .. " CTRL", "S", "screenshot in 5s", "exec", sh("$scriptsDir/ScreenShot.sh --in5") },
    { mainMod .. " CTRL SHIFT", "S", "screenshot in 10s", "exec", sh("$scriptsDir/ScreenShot.sh --in10") },
    { "ALT", "S", "screenshot active window", "exec", sh("$scriptsDir/ScreenShot.sh --active") },

    { mainMod .. " CTRL", "left", "move window left", "movewindow", "l" },
    { mainMod .. " CTRL", "right", "move window right", "movewindow", "r" },
    { mainMod .. " CTRL", "up", "move window up", "movewindow", "u" },
    { mainMod .. " CTRL", "down", "move window down", "movewindow", "d" },

    { mainMod .. " ALT", "left", "swap window left", "swapwindow", "l" },
    { mainMod .. " ALT", "right", "swap window right", "swapwindow", "r" },
    { mainMod .. " ALT", "up", "swap window up", "swapwindow", "u" },
    { mainMod .. " ALT", "down", "swap window down", "swapwindow", "d" },

    { mainMod, "G", "toggle group", "togglegroup", "" },
    { mainMod, "Tab", "Change Group Forward", "changegroupactive", "f" },
    { mainMod .. " CTRL", "tab", "change active in group", "changegroupactive", "" },
    { mainMod .. " SHIFT", "Tab", "Change Group Back", "changegroupactive", "b" },

    { mainMod .. " CTRL", "K", "Move left into group", "moveintogroup", "l" },
    { mainMod .. " CTRL", "L", "Move Right into group", "moveintogroup", "r" },
    { mainMod .. " CTRL", "H", "Move active out of group", "moveoutofgroup", "" },

    { mainMod, "left", "focus left", "movefocus", "l" },
    { mainMod, "right", "focus right", "movefocus", "r" },
    { mainMod, "up", "focus up", "movefocus", "u" },
    { mainMod, "down", "focus down", "movefocus", "d" },

    { mainMod, "tab", "next workspace", "workspace", "m+1" },
    { mainMod .. " SHIFT", "tab", "previous workspace", "workspace", "m-1" },

    { mainMod .. " SHIFT", "U", "move to special workspace", "movetoworkspace", "special" },
    { mainMod, "U", "toggle special workspace", "togglespecialworkspace", "" },

    { mainMod .. " SHIFT", "bracketleft", "move to previous workspace", "movetoworkspace", "-1" },
    { mainMod .. " SHIFT", "bracketright", "move to next workspace", "movetoworkspace", "+1" },
    { mainMod .. " CTRL", "bracketleft", "move silently to previous workspace", "movetoworkspacesilent", "-1" },
    { mainMod .. " CTRL", "bracketright", "move silently to next workspace", "movetoworkspacesilent", "+1" },

    { mainMod, "mouse_down", "next workspace", "workspace", "e+1" },
    { mainMod, "mouse_up", "previous workspace", "workspace", "e-1" },
    { mainMod, "period", "next workspace", "workspace", "e+1" },
    { mainMod, "comma", "previous workspace", "workspace", "e-1" },
  },

  bind = {
    { "CTRL ALT", "Delete", "exec", home .. "/.config/hypr/scripts/toggle_sysmon.sh" },
    { "CTRL ALT", "L", "exec", "qs -p ~/.config/quickshell-noctalia ipc call lockScreen lock" },
  },

  bindeld = {
    { "", "xf86audioraisevolume", "volume up", "exec", sh("$scriptsDir/Volume.sh --inc") },
    { "", "xf86audiolowervolume", "volume down", "exec", sh("$scriptsDir/Volume.sh --dec") },
    { "ALT", "xf86audioraisevolume", "volume up precise", "exec", sh("$scriptsDir/Volume.sh --inc-precise") },
    { "ALT", "xf86audiolowervolume", "volume down precise", "exec", sh("$scriptsDir/Volume.sh --dec-precise") },
  },

  bindld = {
    { "", "xf86AudioMicMute", "toggle mic mute", "exec", sh("$scriptsDir/Volume.sh --toggle-mic") },
    { "", "xf86audiomute", "toggle mute", "exec", sh("$scriptsDir/Volume.sh --toggle") },
    { "", "xf86Sleep", "sleep", "exec", "systemctl suspend" },
    { "", "xf86Rfkill", "airplane mode", "exec", sh("$scriptsDir/AirplaneMode.sh") },

    { "", "xf86AudioPlayPause", "play/pause", "exec", sh("$scriptsDir/MediaCtrl.sh --pause") },
    { "", "xf86AudioPause", "pause", "exec", sh("$scriptsDir/MediaCtrl.sh --pause") },
    { "", "xf86AudioPlay", "play", "exec", sh("$scriptsDir/MediaCtrl.sh --pause") },
    { "", "xf86AudioNext", "next track", "exec", sh("$scriptsDir/MediaCtrl.sh --nxt") },
    { "", "xf86AudioPrev", "previous track", "exec", sh("$scriptsDir/MediaCtrl.sh --prv") },
    { "", "xf86audiostop", "stop", "exec", sh("$scriptsDir/MediaCtrl.sh --stop") },
  },

  binded = {
    { mainMod .. " SHIFT", "left", "resize left (-50)", "resizeactive", "-50 0" },
    { mainMod .. " SHIFT", "right", "resize right (+50)", "resizeactive", "50 0" },
    { mainMod .. " SHIFT", "up", "resize up (-50)", "resizeactive", "0 -50" },
    { mainMod .. " SHIFT", "down", "resize down (+50)", "resizeactive", "0 50" },
  },

  bindmd = {
    { mainMod, "mouse:272", "move window", "movewindow", "" },
    { mainMod, "mouse:273", "resize window", "resizewindow", "" },
  },

  exec_once = {
    sh("$scriptsDir/ChangeLayout.sh init"),
  },
})

-- Workspace number binds
for i = 1, 10 do
  local keycode = "code:" .. tostring(i + 9)
  local workspace = tostring(i)

  hl.config({
    bindd = {
      { mainMod, keycode, "workspace " .. workspace, "workspace", workspace },
      { mainMod .. " SHIFT", keycode, "move to workspace " .. workspace, "movetoworkspace", workspace },
      { mainMod .. " CTRL", keycode, "move silently to workspace " .. workspace, "movetoworkspacesilent", workspace },
    },
  })
end