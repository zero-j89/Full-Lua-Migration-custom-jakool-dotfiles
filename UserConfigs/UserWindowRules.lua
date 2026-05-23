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
  center = true,
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