local home = os.getenv("HOME")

local mainMod = "SUPER"
local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"
local userConfigs = home .. "/.config/hypr/UserConfigs"

-- User custom keybinds go here.
-- Example:
-- hl.config({
--   unbind = {
--     { mainMod, "Return", "Open terminal", "exec", _G.term or "kitty" },
--   },
--
--   bindd = {
--     { mainMod, "Return", "Open terminal", "exec", "ghostty" },
--     { mainMod, "Z", "My z app", "exec", "APPNAME" },
--   },
-- })

-- VM keyboard passthrough example:
-- hl.config({
--   bind = {
--     { mainMod .. " ALT", "P", "submap", "passthru" },
--   },
-- })
--
-- hl.config({
--   submap = "passthru",
--   bind = {
--     { mainMod .. " ALT", "P", "submap", "reset" },
--   },
-- })
--
-- hl.config({
--   submap = "reset",
-- })