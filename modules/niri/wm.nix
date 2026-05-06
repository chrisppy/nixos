_: {
  flake.modules = {
    nixos.niri = {
      programs.niri = {
        enable = true;
        useNautilus = true;
        withXDG = true;
        withUWSM = true;
      };
    };

    homeManager.niri =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        wayland.windowManager.niri = {
          enable = true;
          settings = {
            prefer-no-csd = true;
            cursor.hide-when-typing = true;
            screenshot-path = "~/pictures/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
            window-rule = [
              {
                match._props.app-id._raw = ''r#"^FreeCAD$"#'';
                open-maximized-to-edges = true;
              }
              {
                match._props.app-id._raw = ''r#"^Inkscape$"#'';
                open-maximized-to-edges = true;
              }
              {
                match._props.app-id._raw = ''r#"^KiCAD$"#'';
                open-maximized-to-edges = true;
              }
              {
                match._props.app-id._raw = ''r#"^Bitwarden$"#'';
                block-out-from = "screen-capture";
              }
            ];
            spawn-at-startup = [
              "${lib.getExe' pkgs.tailscale "tailscale"} systray"
            ]
            ++ lib.optionals config.programs.discord.enable [
              "${lib.getExe config.programs.discord.package} --start-minimized"
            ];
          };
        };
      };
  };
}
