hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("wind", {
  type = "spring",
  mass = 1,
  stiffness = 60,
  dampening = 7,
})

hl.curve("winIn", {
  type = "spring",
  mass = 0.9,
  stiffness = 72,
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

hl.curve("md3_decel", {
  type = "bezier",
  points = {
    { 0.05, 0.7 },
    { 0.1, 1 },
  },
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
  style = "once",
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
  leaf = "fade",
  enabled = true,
  speed = 3,
  bezier = "md3_decel",
})

hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 3,
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
  leaf = "fadeLayersIn",
  enabled = true,
  speed = 2,
  bezier = "menu_decel",
})

hl.animation({
  leaf = "fadeLayersOut",
  enabled = true,
  speed = 5,
  bezier = "menu_accel",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 7,
  bezier = "menu_decel",
  style = "slide",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  spring = "wind",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 3,
  bezier = "md3_decel",
  style = "slidefadevert 15%",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 3,
  bezier = "md3_decel",
  style = "slidevert",
})