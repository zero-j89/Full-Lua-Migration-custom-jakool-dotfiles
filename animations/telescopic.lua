hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("overshot", {
  type = "spring",
  mass = 1,
  stiffness = 68,
  dampening = 5,
})

hl.curve("smoothOut", {
  type = "bezier",
  points = {
    { 0.5, 0 },
    { 0.99, 0.99 },
  },
})

hl.curve("smoothIn", {
  type = "spring",
  mass = 0.8,
  stiffness = 85,
  dampening = 6,
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 5,
  spring = "overshot",
  style = "slide",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 3,
  bezier = "smoothOut",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 3,
  bezier = "smoothOut",
})

hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 4,
  spring = "smoothIn",
  style = "slide",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 5,
  bezier = "default",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 5,
  spring = "smoothIn",
})

hl.animation({
  leaf = "fadeDim",
  enabled = true,
  speed = 5,
  spring = "smoothIn",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 6,
  bezier = "default",
  style = "slide",
})