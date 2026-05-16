hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0, 0 },
    { 1, 1 },
  },
})

hl.curve("md3_standard", {
  type = "bezier",
  points = {
    { 0.2, 0 },
    { 0, 1 },
  },
})

hl.curve("md3_decel", {
  type = "bezier",
  points = {
    { 0.05, 0.7 },
    { 0.1, 1 },
  },
})

hl.curve("md3_accel", {
  type = "bezier",
  points = {
    { 0.3, 0 },
    { 0.8, 0.15 },
  },
})

hl.curve("overshot", {
  type = "spring",
  mass = 1,
  stiffness = 55,
  dampening = 6,
})

hl.curve("crazyshot", {
  type = "spring",
  mass = 0.8,
  stiffness = 75,
  dampening = 4,
})

hl.curve("menu_decel", {
  type = "bezier",
  points = {
    { 0.1, 1 },
    { 0, 1 },
  },
})

hl.curve("menu_accel", {
  type = "bezier",
  points = {
    { 0.38, 0.04 },
    { 1, 0.07 },
  },
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4,
  bezier = "md3_decel",
  style = "popin 70%",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4,
  spring = "overshot",
  style = "popin 80%",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 3,
  bezier = "md3_accel",
  style = "popin 40%",
})

hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 5,
  spring = "crazyshot",
  style = "slide",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 10,
  bezier = "linear",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 4,
  bezier = "md3_decel",
})

hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "menu_decel",
  style = "slide",
})

hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 2,
  bezier = "menu_accel",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 7,
  spring = "overshot",
  style = "slide",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 5,
  spring = "crazyshot",
  style = "slidevert",
})