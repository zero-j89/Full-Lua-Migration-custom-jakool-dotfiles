local hl = require("hyprland")

hl.config({
  env = {
    { "DOTS_VERSION", "2.3.20" },

    -- Toolkit Backend Variables
    { "GDK_BACKEND", "wayland,x11,*" },
    { "QT_QPA_PLATFORM", "wayland;xcb" },
    { "CLUTTER_BACKEND", "wayland" },

    -- SDL
    -- { "SDL_VIDEODRIVER", "wayland" },

    -- XDG Specifications
    { "XDG_CURRENT_DESKTOP", "Hyprland" },
    { "XDG_SESSION_DESKTOP", "Hyprland" },
    { "XDG_SESSION_TYPE", "wayland" },

    -- QT Variables
    { "QT_AUTO_SCREEN_SCALE_FACTOR", "1" },
    { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
    { "QT_QPA_PLATFORMTHEME", "qt5ct" },
    { "QT_QPA_PLATFORMTHEME", "qt6ct" },

    -- hyprland-qt-support
    { "QT_QUICK_CONTROLS_STYLE", "org.hyprland.style" },

    -- Scaling
    { "GDK_SCALE", "1" },
    { "QT_SCALE_FACTOR", "1" },

    -- Cursor
    { "HYPRCURSOR_THEME", "Bibata-Modern-Ice" },
    { "HYPRCURSOR_SIZE", "24" },

    -- Firefox
    { "MOZ_ENABLE_WAYLAND", "1" },

    -- Electron
    { "ELECTRON_OZONE_PLATFORM_HINT", "auto" },

    -- NVIDIA
    { "LIBVA_DRIVER_NAME", "nvidia" },
    { "__GLX_VENDOR_LIBRARY_NAME", "nvidia" },
    { "NVD_BACKEND", "direct" },
    { "GSK_RENDERER", "ngl" },

    -- Optional NVIDIA
    -- { "GBM_BACKEND", "nvidia-drm" },
    -- { "__GL_GSYNC_ALLOWED", "1" },
    -- { "__NV_PRIME_RENDER_OFFLOAD", "1" },
    -- { "__VK_LAYER_NV_optimus", "NVIDIA_only" },
    -- { "WLR_DRM_NO_ATOMIC", "1" },

    -- VM / Software Rendering
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

    -- Hyprland ENV
    -- { "HYPRLAND_TRACE", "1" },
    -- { "HYPRLAND_NO_RT", "1" },
    -- { "HYPRLAND_NO_SD_NOTIFY", "1" },
    -- { "HYPRLAND_NO_SD_VARS", "1" },
  },
})