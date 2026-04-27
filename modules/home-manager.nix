{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules = {
    nixos = {
      base = {
        imports = [inputs.home-manager.nixosModules.home-manager];

        home-manager = {
          useGlobalPkgs = true;
          extraSpecialArgs = {
            hasGlobalPkgs = true;
            inherit inputs;
          };
          users.${username}.imports = [
            (
              {osConfig, ...}: {
                home.stateVersion = osConfig.system.stateVersion;
              }
            )
            config.flake.modules.homeManager.base
          ];
        };
      };
      pc = {
        imports = [config.flake.modules.nixos.base];

        home-manager.users.${username}.imports = with config.flake.modules.homeManager; [
          dev
          gui
          wayland
        ];

        hardware.graphics.enable = true;
      };
      hyprland = {
        imports = [config.flake.modules.nixos.pc];

        home-manager.users.${username}.imports = with config.flake.modules.homeManager; [
          hyprland
        ];
      };
      niri = {
        imports = [config.flake.modules.nixos.pc];

        home-manager.users.${username}.imports = with config.flake.modules.homeManager; [
          niri
        ];
      };
    };
    homeManager.base = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        fonts.fontconfig.enable = true;
      };
      news.display = "silent";
      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    };
  };
}
