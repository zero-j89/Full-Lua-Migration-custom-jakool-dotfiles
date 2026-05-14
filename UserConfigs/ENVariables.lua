
hl.config({
  env = {

    -- QT Variables
    -- { "QT_AUTO_SCREEN_SCALE_FACTOR", "1" },
    -- { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
    -- { "QT_QPA_PLATFORMTHEME", "qt5ct" },
    -- { "QT_QPA_PLATFORMTHEME", "qt6ct" },

    -- XWayland scaling
    -- { "GDK_SCALE", "1" },
    -- { "QT_SCALE_FACTOR", "1" },

    -- NVIDIA
    { "LIBVA_DRIVER_NAME", "nvidia" },
    { "__GLX_VENDOR_LIBRARY_NAME", "nvidia" },
    { "NVD_BACKEND", "direct" },
    -- { "GSK_RENDERER", "ngl" },

    -- Additional NVIDIA variables
    { "GBM_BACKEND", "nvidia-drm" },
    { "__GL_GSYNC_ALLOWED", "1" },

    -- { "__NV_PRIME_RENDER_OFFLOAD", "1" },
    -- { "__VK_LAYER_NV_optimus", "NVIDIA_only" },
    -- { "WLR_DRM_NO_ATOMIC", "1" },

    -- Software rendering / VM
    -- { "LIBGL_ALWAYS_SOFTWARE", "1" },
    -- { "WLR_RENDERER_ALLOW_SOFTWARE", "1" },

    -- NVIDIA Firefox
    -- { "MOZ_DISABLE_RDD_SANDBOX", "1" },
    -- { "EGL_PLATFORM", "wayland" },

    -- Aquamarine
    -- { "AQ_TRACE", "1" },
    -- { "AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0" },
    -- { "AQ_MGPU_NO_EXPLICIT", "1" },
    -- { "AQ_NO_MODIFIERS", "1" },
  },
})