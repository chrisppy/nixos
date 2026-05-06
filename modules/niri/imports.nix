{ inputs, config, ... }:
let
  inherit (config.flake.modules.homeManager) noctalia;
in
{
  flake.modules = {
    nixos.niri.imports = [
      inputs.niri-nix.nixosModules.default
    ];
    homeManager.niri.imports = [
      noctalia
      inputs.niri-nix.homeModules.default
    ];
  };
}
