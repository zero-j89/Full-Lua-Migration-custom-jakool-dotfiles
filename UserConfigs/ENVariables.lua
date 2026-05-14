-- NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- Additional NVIDIA variables
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_GSYNC_ALLOWED", "1")

-- Optional
-- hl.env("GSK_RENDERER", "ngl")
-- hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
-- hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
-- hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
-- hl.env("EGL_PLATFORM", "wayland")
-- hl.env("AQ_TRACE", "1")
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0")
-- hl.env("AQ_MGPU_NO_EXPLICIT", "1")
-- hl.env("AQ_NO_MODIFIERS", "1")