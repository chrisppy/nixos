{ inputs, ... }:
{
  flake.modules.nixos.audiobookshelf =
    { pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      services.audiobookshelf = {
        enable = true;
        package = unstable.audiobookshelf;
        openFirewall = true;
        host = "127.0.0.1";
        port = 13378;
      };
    };
}
