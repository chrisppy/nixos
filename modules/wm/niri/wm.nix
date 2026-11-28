_: {
  flake.modules.nixos.niri =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.niri = {
        enable = true;
        # The wrapped niri, with the config below built in.
        package = config.wrappers.niri.package;
        useNautilus = true;
        withXDG = true;
        withUWSM = true;
      };

      wrappers.niri = {
        install = false; # programs.niri installs it
        module.settings = {
          prefer-no-csd = _: { };
          cursor = {
            xcursor-theme = config.stylix.cursor.name;
            xcursor-size = config.stylix.cursor.size;
            hide-when-typing = _: { };
          };
          screenshot-path = "~/pictures/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          window-rules = [
            {
              matches = [ { app-id = _: { custom = ''r#"^FreeCAD$"#''; }; } ];
              open-maximized-to-edges = true;
            }
          ];
          spawn-at-startup = [
            [
              (lib.getExe' pkgs.tailscale "tailscale")
              "systray"
            ]
            [
              (lib.getExe pkgs.discord)
              "--start-minimized"
            ]
          ];
        };
      };
    };
}
