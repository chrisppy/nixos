_: {
  flake.modules = {
    nixos.hyprland = {
      inputs,
      pkgs,
      ...
    }: {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };
    };
    homeManager.hyprland = {
      inputs,
      pkgs,
      ...
    }: {
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        systemd.enable = true;

        xdg.portal.extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];

        settings = {
          env = [
            "_JAVA_AWT_WM_NONREPARENTING,1"
            "GDK_BACKEND,wayland,x11,*"
            "GTK_CSD,0"
            "MOZ_ENABLE_WAYLAND,1"
            "MOZ_WEBRENDER,1"
            "NIXOS_OZONE_WL,1"
            "QT_QPA_PLATFORM,wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "SDL_VIDEODRIVER,wayland"
          ];
          monitor = [
            "desc:LG Electronics LG HDR WFHD 0x00017724, preferred, 0x0, 1"
          ];
          cursor.hide_on_key_press = true;
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
          general = {
            allow_tearing = false;
            border_size = 2;
            gaps_in = 5;
            gaps_out = 10;
            layout = "scrolling";
            resize_on_border = true;
          };
          input = {
            sensitivity = 0.0;
            accel_profile = "flat";
            follow_mouse = 1;
            mouse_refocus = true;
          };
          scrolling = {
            column_width = 0.5;
            focus_fit_method = 1;
            fullscreen_on_one_column = true;
          };
        };
      };

      home.packages = with pkgs; [
        hyprpwcenter
        hyprsysteminfo
      ];

      programs = {
        hyprlock = {
          enable = true;
          package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
        };
        hyprshot.enable = true;
      };

      services = {
        hypridle = {
          enable = true;
          package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
        };
        hyprpolkitagent = {
          enable = true;
          package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprpolkitagent;
        };
        hyprpaper = {
          enable = true;
          package = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
        };
      };
    };
  };
}
