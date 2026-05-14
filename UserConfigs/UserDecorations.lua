local hl = require("hyprland")
local home = os.getenv("HOME")

-- Wallust colors
dofile(home .. "/.config/hypr/wallust/wallust-hyprland.lua")

hl.config({

  general = {
    border_size = 2,
    gaps_in = 2,
    gaps_out = 4,

    ["col.active_border"] = _G.color12,
    ["col.inactive_border"] = _G.color10,
  },

  decoration = {
    rounding = 10,

    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,

    dim_inactive = true,
    dim_strength = 0.1,
    dim_special = 0.8,

    shadow = {
      enabled = false,
      range = 3,
      render_power = 1,

      color = _G.color12,
      color_inactive = _G.color10,
    },

    blur = {
      enabled = true,
      size = 2,
      passes = 1,

      -- May be deprecated later; keeping for compatibility
      new_optimizations = true,

      xray = true,
      ignore_opacity = true,
      special = true,
      popups = true,
    },
  },

  group = {
    ["col.border_active"] = _G.color15,

    groupbar = {
      ["col.active"] = _G.color0,
    },
  },
})