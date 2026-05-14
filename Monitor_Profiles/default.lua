#local hl = require("hyprland")

hl.config({
  monitor = {
    ",preferred,auto,1",
    ",highrr,auto,1",
    ",highres,auto,1",

    -- Examples preserved from original config:

    -- "eDP-1,preferred,auto,1",
    -- "eDP-1,2560x1440@165,0x0,1",
    -- "DP-3,1920x1080@240,auto,1",
    -- "DP-1,preferred,auto,1",
    -- "HDMI-A-1,preferred,auto,1",

    -- Virtual displays
    -- "Virtual-1,1920x1080@60,auto,1",

    -- Disable monitor
    -- "name,disable",

    -- Mirror examples
    -- "DP-3,1920x1080@60,0x0,1,mirror,DP-2",
    -- ",preferred,auto,1,mirror,eDP-1",
    -- "HDMI-A-1,2560x1440@144,0x0,1,mirror,eDP-1",

    -- 10-bit support
    -- ",preferred,auto,1,bitdepth,10",

    -- Extra monitor options
    -- "eDP-1,transform,0",
    -- "eDP-1,addreserved,10,10,10,49",
  },
})