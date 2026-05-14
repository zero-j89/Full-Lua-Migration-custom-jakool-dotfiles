-- WorkspaceRules.lua
-- NOTE: This is NOT loaded by default.
-- Real active workspace rules are in:
-- ~/.config/hypr/workspaces.lua
-- and are usually generated/managed by nwg-displays.

-- Examples only:

-- local hl = require("hyprland")

-- hl.config({
--   workspace = {
--     "1,monitor:eDP-1",
--     "2,monitor:eDP-1",
--     "3,monitor:eDP-1",
--     "4,monitor:eDP-1",
--     "5,monitor:DP-2",
--     "6,monitor:DP-2",
--     "7,monitor:DP-2",
--     "8,monitor:DP-2",

--     "3,rounding:false,decorate:false",
--     "name:coding,rounding:false,decorate:false,gapsin:0,gapsout:0,border:false,monitor:DP-1",
--     "8,bordersize:8",
--     "name:Hello,monitor:DP-1,default:true",
--     "name:gaming,monitor:desc:Chimei Innolux Corporation 0x150C,default:true",
--     "5,on-created-empty:[float] firefox",
--     "special:scratchpad,on-created-empty:foot",
--   },
-- })