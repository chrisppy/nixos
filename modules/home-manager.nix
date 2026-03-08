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
          extraSpecialArgs.hasGlobalPkgs = true;
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
        home-manager.users.${username}.imports = with config.flake.modules.homeManager; [
          dev
          gui
        ];
      };
    };
    homeManager.base = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };
      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    };
  };
}
