{ inputs, ... }:
{
  flake.modules.nixos.niri = {
    imports = [
      inputs.niri-nix.nixosModules.default
    ];
    nixpkgs.overlays = [
      inputs.niri-nix.overlays.niri-nix
    ];
  };
}
