{
  inputs,
  config,
  ...
}: let
  inherit (config.flake.modules.homeManager) noctalia;
in {
  flake.modules = {
    nixos.niri.imports = [inputs.niri-module.nixosModules.niri];

    homeManager.niri.imports = [
      inputs.niri-module.homeModules.niri
      noctalia
    ];
  };
}
