{inputs, ...}: {
  flake.modules.nixos.audiobookshelf = {pkgs, ...}: let
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  in {
    services.audiobookshelf = {
      enable = true;
      package = unstable.audiobookshelf;
      openFirewall = true;
      host = "0.0.0.0";
      port = 13378;
      dataDir = "/mnt/stillhouse/audiobooks";
    };
  };
}
