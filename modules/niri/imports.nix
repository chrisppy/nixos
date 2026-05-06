{ inputs, config, ... }:
let
  inherit (config.flake.modules.homeManager) fuzzel waybar wpaperd;
in
{
  flake.modules = {
    nixos.niri = {
      imports = [
        inputs.niri-nix.nixosModules.default
      ];
      nixpkgs.overlays = [
        inputs.niri-nix.overlays.niri-nix
      ];
    };
    homeManager.niri.imports = [
      fuzzel
      waybar
      wpaperd
      inputs.niri-nix.homeModules.default
    ];
  };
}
