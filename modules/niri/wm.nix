{inputs, ...}: {
  flake.modules = {
    nixos.niri = {
      lib,
      pkgs,
      ...
    }: {
      nixpkgs.overlays = [inputs.niri-module.overlays.niri];
      programs = {
        niri = {
          enable = true;
          # package = pkgs.niri-stable;
        };
        regreet.enable = true;
      };

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${lib.getExe pkgs.cage} -s -- regreet";
          user = "greeter";
        };
      };
    };

    homeManager.niri = {pkgs, ...}: {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config.common.default = "*";
      };

      programs.niri = {
        enable = true;
          # package = pkgs.niri-stable;
        settings = {
          prefer-no-csd = true;
          cursor.hide-when-typing = true;
          screenshot-path = "~/pictures/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        };
      };
    };
  };
}
