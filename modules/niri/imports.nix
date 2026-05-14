{ inputs, config, ... }:
let
  inherit (config.flake.modules.homeManager)
    fuzzel
    tofi
    waybar
    wpaperd
    ;
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
      tofi
      waybar
      wpaperd
      inputs.niri-nix.homeModules.default
    ];
  };
}
