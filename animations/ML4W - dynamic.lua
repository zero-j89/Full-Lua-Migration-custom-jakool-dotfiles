hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("wind", {
  type = "spring",
  mass = 1,
  stiffness = 62,
  dampening = 7,
})

hl.curve("winIn", {
  type = "spring",
  mass = 0.9,
  stiffness = 76,
  dampening = 6,
})

hl.curve("winOut", {
  type = "bezier",
  points = {
    { 0.3, -0.3 },
    { 0, 1 },
  },
})

hl.curve("liner", {
  type = "bezier",
  points = {
    { 1, 1 },
    { 1, 1 },
  },
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 6,
  spring = "wind",
  style = "slide",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 6,
  spring = "winIn",
  style = "slide",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 5,
  bezier = "winOut",
  style = "slide",
})

hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 5,
  spring = "wind",
  style = "slide",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 1,
  bezier = "liner",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 30,
  bezier = "liner",
  style = "loop",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 10,
  bezier = "default",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  spring = "wind",
  style = "slide",
})