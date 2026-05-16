local function wr(rule)
  hl.window_rule(rule)
end

local function lr(rule)
  hl.layer_rule(rule)
end

-- TAGS

-- browser tags
wr({ match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" }, tag = "+browser" })
wr({ match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
wr({ match = { class = "^(chrome-.+-Default)$" }, tag = "+browser" })
wr({ match = { class = "^([Cc]hromium)$" }, tag = "+browser" })
wr({ match = { class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" }, tag = "+browser" })
wr({ match = { class = "^(Brave-browser(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
wr({ match = { class = "^([Tt]horium-browser|[Cc]achy-browser)$" }, tag = "+browser" })
wr({ match = { class = "^(zen-alpha|zen)$" }, tag = "+browser" })

-- notif tags
wr({ match = { class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" }, tag = "+notif" })

-- KooL settings tag
wr({ match = { title = "^(KooL Quick Cheat Sheet)$" }, tag = "+KooL_Cheat" })
wr({ match = { title = "^(KooL Hyprland Settings)$" }, tag = "+KooL_Settings" })
wr({ match = { class = "^(nwg-displays|nwg-look)$" }, tag = "+KooL-Settings" })

-- terminal tags
wr({ match = { class = "^(Alacritty|kitty|kitty-dropterm)$" }, tag = "+terminal" })

-- email tags
wr({ match = { class = "^([Tt]hunderbird|org.mozilla.Thunderbird)$" }, tag = "+email" })
wr({ match = { class = "^(eu.betterbird.Betterbird)$" }, tag = "+email" })
wr({ match = { class = "^(org.gnome.Evolution)$" }, tag = "+email" })

-- project tags
wr({ match = { class = "^(codium|codium-url-handler|VSCodium)$" }, tag = "+projects" })
wr({ match = { class = "^(VSCode|code|code-url-handler)$" }, tag = "+projects" })
wr({ match = { class = "^(jetbrains-.+)$" }, tag = "+projects" })
wr({ match = { class = "^(dev.zed.Zed|antigravity)$" }, tag = "+projects" })

-- screenshare tags
wr({ match = { class = "^(com.obsproject.Studio)$" }, tag = "+screenshare" })

-- IM tags
wr({ match = { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" }, tag = "+im" })
wr({ match = { class = "^([Ff]erdium)$" }, tag = "+im" })
wr({ match = { class = "^([Ww]hatsapp-for-linux)$" }, tag = "+im" })
wr({ match = { class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" }, tag = "+im" })
wr({ match = { class = "^(teams-for-linux)$" }, tag = "+im" })
wr({ match = { class = "^(im.riot.Riot|Element)$" }, tag = "+im" })

-- game tags
wr({ match = { class = "^(gamescope)$" }, tag = "+games" })
wr({ match = { class = "^(steam_app_\\d+)$" }, tag = "+games" })

-- gamestore tags
wr({ match = { class = "^([Ss]team)$" }, tag = "+gamestore" })
wr({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })
wr({ match = { class = "^(com.heroicgameslauncher.hgl)$" }, tag = "+gamestore" })

-- file-manager tags
wr({ match = { class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" }, tag = "+file-manager" })
wr({ match = { class = "^(app.drey.Warp)$" }, tag = "+file-manager" })

-- wallpaper tags
wr({ match = { class = "^([Ww]aytrogen)$" }, tag = "+wallpaper" })

-- multimedia tags
wr({ match = { class = "^([Aa]udacious)$" }, tag = "+multimedia" })

-- multimedia-video tags
wr({ match = { class = "^([Mm]pv|vlc)$" }, tag = "+multimedia_video" })

-- settings tags
wr({ match = { title = "^(ROG Control)$" }, tag = "+settings" })
wr({ match = { class = "^(wihotspot(-gui)?)$" }, tag = "+settings" })
wr({ match = { class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" }, tag = "+settings" })
wr({ match = { class = "^(gnome-disks|wihotspot(-gui)?)$" }, tag = "+settings" })
wr({ match = { title = "(Kvantum Manager)" }, tag = "+settings" })
wr({ match = { class = "^(file-roller|org.gnome.FileRoller)$" }, tag = "+settings" })
wr({ match = { class = "^(nm-applet|nm-connection-editor|blueman-manager)$" }, tag = "+settings" })
wr({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, tag = "+settings" })
wr({ match = { class = "^(qt5ct|qt6ct)$" }, tag = "+settings" })
wr({ match = { class = "(xdg-desktop-portal-gtk)" }, tag = "+settings" })
wr({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, tag = "+settings" })
wr({ match = { class = "^([Rr]ofi)$" }, tag = "+settings" })
wr({ match = { class = "^(btrfs-assistant)$" }, tag = "+settings" })
wr({ match = { class = "^(timeshift-gtk)$" }, tag = "+settings" })

-- viewer tags
wr({ match = { class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" }, tag = "+viewer" })
wr({ match = { class = "^(evince)$" }, tag = "+viewer" })
wr({ match = { class = "^(eog|org.gnome.Loupe)$" }, tag = "+viewer" })

-- SPECIAL OVERRIDES
wr({ match = { tag = "multimedia_video" }, no_blur = true })
wr({ match = { tag = "multimedia_video" }, opacity = "1.0" })
wr({ match = { tag = "multimedia" }, no_blur = true })
wr({ match = { tag = "multimedia" }, opacity = "1.0" })

-- POSITION
wr({ match = { tag = "KooL_Cheat" }, center = true })
wr({ match = { tag = "KooL-Settings" }, center = true })
wr({ match = { title = "^(ROG Control)$" }, center = true })
wr({ match = { title = "^(Keybindings)$" }, center = true })
wr({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
wr({ match = { class = "^([Ff]erdium)$" }, center = true })

-- IDLE INHIBIT
wr({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
wr({ match = { fullscreen = "1" }, idle_inhibit = "fullscreen" })
wr({ match = { class = "^(.*)$" }, idle_inhibit = "fullscreen" })
wr({ match = { title = "^(.*)$" }, idle_inhibit = "fullscreen" })

-- FLOAT
wr({ match = { tag = "KooL_Cheat" }, float = true })
wr({ match = { tag = "wallpaper" }, float = true, center = true })
wr({ match = { tag = "settings" }, float = true, center = true })
wr({ match = { tag = "viewer" }, float = true, center = true })
wr({ match = { tag = "KooL-Settings" }, float = true, center = true })
wr({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)" }, float = true })
wr({ match = { class = "(org.gnome.Calculator|qalculate-gtk)" }, float = true })
wr({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" }, float = true })
wr({ match = { class = "^([Qq]alculate-gtk)$" }, float = true })
wr({ match = { class = "^([Ff]erdium)$" }, float = true })

-- POPUPS AND DIALOGS
wr({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
wr({ match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" }, float = true })
wr({ match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" }, float = true })
wr({ match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, float = true })
wr({ match = { title = "^(Add Folder to Workspace)$" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.6)", center = true })
wr({ match = { title = "^(Save As)$" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.6)", center = true })
wr({ match = { initial_title = "(Open Files)" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.6)" })
wr({ match = { title = "^(SDDM Background)$" }, float = true, center = true, size = "(monitor_w*0.16) (monitor_h*0.12)" })
wr({ match = { class = "^(yad)$" }, float = true, center = true, size = "(monitor_w*0.2) (monitor_h*0.2)" })
wr({ match = { class = "^(hyprland-donate-screen)$" }, float = true, center = true })

-- OPACITY
wr({ match = { tag = "browser" }, opacity = "0.99 0.8" })
wr({ match = { tag = "projects" }, opacity = "0.9 0.8" })
wr({ match = { tag = "im" }, opacity = "0.94 0.86" })
wr({ match = { tag = "multimedia" }, opacity = "0.94 0.86" })
wr({ match = { tag = "file-manager" }, opacity = "0.9 0.8" })
wr({ match = { tag = "terminal" }, opacity = "0.9 0.7" })
wr({ match = { tag = "settings" }, opacity = "0.8 0.7" })
wr({ match = { tag = "viewer" }, opacity = "0.82 0.75" })
wr({ match = { tag = "wallpaper" }, opacity = "0.9 0.7" })
wr({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
wr({ match = { class = "^(deluge)$" }, opacity = "0.9 0.8" })
wr({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" })
wr({ match = { title = "^(Picture-in-Picture)$" }, opacity = "0.95 0.75" })

-- SIZE
wr({ match = { tag = "KooL_Cheat" }, size = "(monitor_w*0.65) (monitor_h*0.9)" })
wr({ match = { tag = "wallpaper" }, size = "(monitor_w*0.7) (monitor_h*0.7)" })
wr({ match = { tag = "settings" }, size = "(monitor_w*0.7) (monitor_h*0.7)" })
wr({ match = { class = "^([Ff]erdium)$" }, size = "(monitor_w*0.6) (monitor_h*0.7)" })

-- BLUR & FULLSCREEN
wr({ match = { tag = "games" }, no_blur = true, fullscreen = 0 })
wr({ match = { tag = "games" }, fullscreen = 0 })

-- NO INITIAL FOCUS
wr({ match = { class = "^(jetbrains-.*)$" }, no_initial_focus = true })
wr({ match = { title = "^(wind.*)$" }, no_initial_focus = true })

-- NAMED RULES
wr({
  name = "Picture-in-Picture",
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
  move = "72% 7%",
  opacity = "0.95 0.75",
  pin = true,
  keep_aspect_ratio = true,
  size = "(monitor_w*0.3) (monitor_h*0.3)",
})

wr({
  name = "Thunar-Progress-bar",
  match = {
    class = "^(thunar)$",
    title = "^(File Operation Progress)$",
  },
  float = true,
  center = true,
  size = "(monitor_w*0.26) (monitor_h*0.18)",
})

-- LAYER RULES
lr({ match = { namespace = "rofi" }, blur = true })
lr({ match = { namespace = "notifications" }, blur = true })
lr({ match = { namespace = "quickshell:overview" }, blur = true })
lr({ match = { namespace = "quickshell:overview" }, ignore_alpha = 0.5 })

lr({ match = { namespace = "quickshell:.*" }, blur = true })
lr({ match = { namespace = "quickshell:.*" }, ignore_alpha = 0.5 })
lr({ match = { namespace = "noctalia-background-.*$" }, blur = true })
lr({ match = { namespace = "noctalia-background-.*$" }, ignore_alpha = 0.5 })

-- TEST RULE: keep only while verifying, remove later if annoying.
-- wr({
--   name = "kitty-test-float",
--   match = { class = "^(kitty)$" },
--   float = true,
--   center = true,
-- })

wr({
  name = "dropdown-terminal",
  match = {
    class = "^(dropdown-terminal)$",
  },
  float = true,
  size = "1200 700",
  move = "680 100",
})

-- Steam main client/library on workspace 5
wr({
  name = "steam-main-workspace-5",
  match = {
    class = "^([Ss]team)$",
    title = "^([Ss]team|Steam)$",
  },
  workspace = "5 silent",
  float = true,
  size = "1280 800",
  move = "1264 625",
})
-- Steam child dialogs/popups stay floating, centered
wr({
  name = "steam-popups-float",
  match = {
    class = "^([Ss]team)$",
    title = "negative:^([Ss]team|Steam)$",
  },
  float = true,
  center = true,
})

-- Steam games on workspace 4
wr({
  name = "steam-games-workspace-4",
  match = {
    class = "^(steam_app_[0-9]+)$",
  },
  workspace = "4 silent",
  no_blur = true,
})

-- Gamescope on workspace 4
wr({
  name = "gamescope-workspace-4",
  match = {
    class = "^(gamescope)$",
  },
  workspace = "4 silent",
  no_blur = true,
})

