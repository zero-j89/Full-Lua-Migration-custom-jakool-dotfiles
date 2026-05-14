
local function wr(rule)
  hl.window_rule(rule)
end

-- Steam panel
wr({
  name = "steam-panel",

  match = {
    class = "^(steam)$",
    title = "^(Steam)$",
  },

  workspace = "5 silent",
  float = true,

  size = "1100 750",
  move = "(monitor_w-1100-12) (monitor_h-750-15)",
})

-- Steam games
wr({
  name = "steam-games",

  match = {
    class = "^(steam_app_.*)$",
  },

  workspace = "4",
})

-- Gamescope
wr({
  name = "gamescope-games",

  match = {
    class = "^(gamescope)$",
  },

  workspace = "4",
})