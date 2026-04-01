{inputs, ...}: {
  flake.modules = {
    nixos.niri = {
      lib,
      pkgs,
      ...
    }: {
      programs = {
        niri = {
          enable = true;
          package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
      wayland.windowManager.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = {
          prefer-no-csd = true;
          cursor.hide-when-typing = true;
          screenshot-path = "~/pictures/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        };
      };
    };
  };
}
