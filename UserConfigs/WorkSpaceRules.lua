-- WorkspaceRules.lua
-- NOTE: This is NOT loaded by default.
-- Real active workspace rules are in:
-- ~/.config/hypr/workspaces.lua
-- and are usually generated/managed by nwg-displays.

-- Examples only:


hl.config({
 workspace = {
    "1,monitor:eDP-3",
    "2,monitor:eDP-3",
    "3,monitor:eDP-3",
    "4,monitor:eDP-3",
    "5,monitor:DP-3",
    "6,monitor:DP-1",
    "7,monitor:DP-1",
    "8,monitor:DP-1",
    "9,monitor:DP-1",
    "10,monitor:DP-1",

    "3,rounding:false,decorate:false",
    "name:coding,rounding:false,decorate:false,gapsin:0,gapsout:0,border:false,monitor:DP-1",
    "8,bordersize:8",
    "name:Hello,monitor:DP-1,default:true",
    "name:gaming,monitor:desc:Chimei Innolux Corporation 0x150C,default:true",
    "5,on-created-empty:[float] firefox",
     "special:scratchpad,on-created-empty:foot",
   },
})