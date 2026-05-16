hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("wind", {
  type = "spring",
  mass = 1,
  stiffness = 70,
  dampening = 8,
})

hl.curve("winIn", {
  type = "spring",
  mass = 0.9,
  stiffness = 78,
  dampening = 7,
})

hl.curve("winOut", {
  type = "bezier",
  points = {
    { 0.20, -0.15 },
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
    { 0.05, 0.80 },
    { 0.10, 0.97 },
  },
})

hl.curve("menu_decel", {
  type = "bezier",
  points = {
    { 0.05, 0.82 },
    { 0, 1 },
  },
})

hl.curve("menu_accel", {
  type = "bezier",
  points = {
    { 0.20, 0 },
    { 0.82, 0.10 },
  },
})

hl.curve("easeOutCirc", {
  type = "bezier",
  points = {
    { 0, 0.48 },
    { 0.38, 1 },
  },
})

hl.curve("OutBack", {
  type = "spring",
  mass = 0.85,
  stiffness = 90,
  dampening = 6,
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 2,
  bezier = "liner",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 82,
  bezier = "liner",
  style = "once",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4,
  spring = "winIn",
  style = "slide",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 3,
  bezier = "easeOutCirc",
})

hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 4,
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
  speed = 3,
  bezier = "menu_accel",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  spring = "OutBack",
  style = "slide",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 3,
  bezier = "md3_decel",
  style = "slidefadevert 15%",
})