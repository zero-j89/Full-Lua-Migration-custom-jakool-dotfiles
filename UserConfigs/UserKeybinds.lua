local home = os.getenv("HOME")

local mainMod = "SUPER"
local scriptsDir = home .. "/.config/hypr/scripts"
local userScripts = home .. "/.config/hypr/UserScripts"
local userConfigs = home .. "/.config/hypr/UserConfigs"

-- User custom keybinds go here.
-- This file currently has no active custom binds.

-- Example: override terminal
-- hl.unbind(mainMod .. " + RETURN")
-- hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"), {
--   description = "Open terminal",
-- })

-- Example: add new bind
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("APPNAME"), {
--   description = "My z app",
-- })

-- VM keyboard passthrough example:
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("passthru"))

-- hl.submap("passthru")
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("reset"))

-- hl.submap("reset")