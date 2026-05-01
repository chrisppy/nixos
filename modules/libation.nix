{ inputs, ... }:
{
  flake.modules.nixos.media =
    { pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = with unstable; [
        libation
      ];
    };
}
