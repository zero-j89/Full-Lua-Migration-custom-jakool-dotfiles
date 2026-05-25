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
  type = "spring",
  mass = 1,
  stiffness = 68,
  dampening = 7,
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
  mass = 0.9,
  stiffness = 82,
  dampening = 5,
})

hl.curve("crazyshot", {
  type = "spring",
  mass = 0.8,
  stiffness = 95,
  dampening = 4,
})

hl.curve("hyprnostretch", {
  type = "bezier",
  points = {
    { 0.05, 0.9 },
    { 0.1, 1.0 },
  },
})

hl.curve("fluent_decel", {
  type = "bezier",
  points = {
    { 0.1, 1 },
    { 0, 1 },
  },
})

hl.curve("easeInOutCirc", {
  type = "bezier",
  points = {
    { 0.85, 0 },
    { 0.15, 1 },
  },
})

hl.curve("easeOutCirc", {
  type = "bezier",
  points = {
    { 0, 0.55 },
    { 0.45, 1 },
  },
})

hl.curve("easeOutExpo", {
  type = "spring",
  mass = 0.9,
  stiffness = 88,
  dampening = 6,
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 3,
  spring = "md3_decel",
  style = "popin 60%",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 10,
  bezier = "default",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 3,
  spring = "md3_decel",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 4,
  spring = "easeOutExpo",
  style = "slide",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 3,
  spring = "md3_decel",
  style = "slidevert",
})