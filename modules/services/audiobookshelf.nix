{ inputs, config, ... }:
let
  inherit (config.flake.lib) mkVHost;
in
{
  flake.modules.nixos.audiobookshelf =
    { config, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      services = {
        audiobookshelf = {
          enable = true;
          package = unstable.audiobookshelf;
          openFirewall = true;
          host = "127.0.0.1";
          port = 13378;
        };
        caddy.virtualHosts = mkVHost "books" config.services.audiobookshelf.port;
      };
    };
}
