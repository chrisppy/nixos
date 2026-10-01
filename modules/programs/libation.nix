{
  inputs,
  ...
}:
{
  flake.modules.nixos.libation =
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
