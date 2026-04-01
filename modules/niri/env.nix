_: {
  flake.modules.homeManager.niri = {
    wayland.windowManager.niri.settings.environment = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GDK_BACKEND = "wayland,x11,*";
      GTK_CSD = "0";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_WEBRENDER = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
    };
  };
}
