{ inputs, ... }:
{
  flake.modules.nixos.media =
    { pkgs, ... }:
    let
      # MakeMKV deletes old releases from its server, so stable's version stops
      # building as soon as a new one ships; unstable tracks the current release.
      # Imported (not legacyPackages) because makemkv is unfree.
      unstable = import inputs.nixpkgs-unstable {
        inherit (pkgs.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    in
    {
      environment.systemPackages = [
        unstable.makemkv
      ];
    };
}
