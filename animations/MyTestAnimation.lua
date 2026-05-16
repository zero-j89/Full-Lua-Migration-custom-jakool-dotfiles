hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("bouncy", {
  type = "spring",
  mass = 1,
  stiffness = 65,
  dampening = 8,
})

hl.curve("smooth", {
  type = "bezier",
  points = {
    { 0.1, 1.0 },
    { 0.0, 1.0 },
  },
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 8,
  spring = "bouncy",
  style = "popin 70%",
})

hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 7,
  spring = "bouncy",
  style = "slide",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 7,
  bezier = "smooth",
  style = "slidevert",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 4,
  bezier = "smooth",
})