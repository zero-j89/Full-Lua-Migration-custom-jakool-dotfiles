hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("quart", {
  type = "spring",
  mass = 1,
  stiffness = 58,
  dampening = 8,
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 6,
  spring = "quart",
  style = "slide",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 6,
  spring = "quart",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 6,
  spring = "quart",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 6,
  spring = "quart",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 6,
  spring = "quart",
  style = "slide",
})