local function wr(rule)
  hl.window_rule(rule)
end

wr({
  name = "steam-games-workspace",
  match = {
    class = "^(steam_app_.*)$",
  },
  workspace = "4",
})

wr({
  name = "gamescope-workspace",
  match = {
    class = "^(gamescope)$",
  },
  workspace = "4",
})