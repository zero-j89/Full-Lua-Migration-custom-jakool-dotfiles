hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("myBezier", {
  type = "spring",
  mass = 1,
  stiffness = 55,
  dampening = 7,
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0.0, 0.0 },
    { 1.0, 1.0 },
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
  stiffness = 78,
  dampening = 6,
})

hl.curve("winOut", {
  type = "bezier",
  points = {
    { 0.3, -0.3 },
    { 0, 1 },
  },
})

hl.curve("slow", {
  type = "spring",
  mass = 1.2,
  stiffness = 40,
  dampening = 9,
})

hl.curve("overshot", {
  type = "spring",
  mass = 0.9,
  stiffness = 80,
  dampening = 5,
})

hl.curve("bounce", {
  type = "spring",
  mass = 0.7,
  stiffness = 105,
  dampening = 3,
})

hl.curve("sligshot", {
  type = "spring",
  mass = 0.8,
  stiffness = 120,
  dampening = 4,
})

hl.curve("nice", {
  type = "spring",
  mass = 0.6,
  stiffness = 140,
  dampening = 2,
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 5,
  spring = "slow",
  style = "popin",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 5,
  bezier = "winOut",
  style = "popin",
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
  speed = 10,
  bezier = "linear",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 100,
  bezier = "linear",
  style = "loop",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 5,
  spring = "overshot",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  spring = "wind",
  style = "slide",
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 5,
  spring = "bounce",
  style = "popin",
})