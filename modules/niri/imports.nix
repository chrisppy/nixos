{ inputs, config, ... }:
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
    homeManager.niri.imports = with config.flake.modules.homeManager; [
      fuzzel
      waybar
      wpaperd
      inputs.niri-nix.homeModules.default
      inputs.niri-nix.homeModules.stylix
    ];
  };
}
