
-- Default editor fallback
_G.edit = os.getenv("EDITOR") or "nano"

-- Default applications
_G.term = "kitty"
_G.files = "thunar"
_G.dropterm = "kitty --class dropdown-terminal"


-- Search engine
_G.Search_Engine = "https://www.google.com/search?q={}"

-- Optional EDITOR environment variable
-- Uncomment if desired:
-- hl.config({
--   env = {
--     { "EDITOR", "vim" },
--   },
-- })
