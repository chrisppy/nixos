{ inputs, ... }:
{
  flake.modules = {
    nixos.niri =
      { pkgs, ... }:
      {
        programs = {
          niri = {
            enable = true;
            package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
          };
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
          package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
          settings = {
            prefer-no-csd = true;
            cursor.hide-when-typing = true;
            screenshot-path = "~/pictures/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
            _children = [
              {
                window-rule._children = [
                  {
                    match._props.app-id = "^FreeCAD$";
                  }
                  {
                    match._props.app-id = "^KiCAD$";
                  }
                  {
                    open-maximized-to-edges = true;
                  }
                ];
              }
              {
                window-rule._children = [
                  {
                    match._props.app-id = "^Bitwarden$";
                  }
                  {
                    block-out-from = "screen-capture";
                  }
                ];
              }
              {
                spawn-at-startup = "${lib.getExe config.programs.discord.package} --start-minimized";
              }
              {
                spawn-at-startup = "${lib.getExe' pkgs.tailscale "tailscale"} systray";
              }
            ];
          };
        };
      };
  };
}
